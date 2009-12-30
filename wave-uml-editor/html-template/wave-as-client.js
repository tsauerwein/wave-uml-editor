// http://code.google.com/p/wave-as-client
// @author sol wu

if(!nextgenapp) var nextgenapp={};
if(!nextgenapp.wave) nextgenapp.wave={};
if(!nextgenapp.wave.gadget) nextgenapp.wave.gadget={};

nextgenapp.wave.gadget = {
	
	/**
	 * setup the callback function.
	 * @param swfName - name of swf element on html.  corresponding to Application.application.id in flex.
	 */
	setStateCallback: function(swfName) {
			
		/*
		 * callback function for stateCallback.   
		 * translate the object to generic object and call the function on flash.
		 * this function is declared here to use swfName variable.   
		 */
		var stateCallback = function() {
			// we need to pass back the entire state object each time, is there a better way?
			var stateCopy = nextgenapp.wave.gadget.unboxState(wave.getState());
			var swfObj = document.getElementById(swfName);
			swfObj.externalWaveStateCallback(stateCopy);
		};
		
		if (wave && wave.isInWaveContainer()) {
			wave.setStateCallback(stateCallback);
		}
	},
	
	/**
	 * setup the callback function.
	 * @param swfName - name of swf element on html. corresponding to Application.application.id in flex.
	 */
	setParticipantCallback: function(swfName) {
	
		/*
		 * callback function for participantCallback.  
		 * translate the object to generic object and call the function on flash.
		 * this function is declared here to use swfName variable.  
		 */
		function participantCallback() {
			// we need to pass back the entire participant object each time, is there a better way?
			var participantsCopy = nextgenapp.wave.gadget.unboxParticipants(wave.getParticipants());
			var swfObj = document.getElementById(swfName);
			swfObj.externalWaveParticipantCallback(participantsCopy);
		}
		
		if (wave && wave.isInWaveContainer()) {
			wave.setParticipantCallback(participantCallback);
		}
	},
	
	getHost: function() {
		var host = wave.getHost();
		return nextgenapp.wave.gadget.unboxParticipant(host);
	},
	
	getViewer: function() {
		var viewer = wave.getViewer();
		return nextgenapp.wave.gadget.unboxParticipant(viewer);
	},
	
	getParticipants: function() {
		var participants = wave.getParticipants();
		return nextgenapp.wave.gadget.unboxParticipants(participants);
	},
	
	getParticipantById: function(participantId) {
		var participant = wave.getParticipantById(participantId);
		return nextgenapp.wave.gadget.unboxParticipant(participant);
	},
	
	getState: function() {
		var stateCopy = wave.getState();
		return nextgenapp.wave.gadget.unboxState(stateCopy);
	},
	
	getMode: function() {
		var mode = wave.getMode();
		return nextgenapp.wave.gadget.unboxMode(mode);
	},

	/**
	 * translate wave.Mode to generic object, so that the generic object can be passed to flex.  
	 */
	unboxMode: function(mode) {
		if (mode == wave.Mode.UNKNOWN) {
			return "unknown";
		} else if (mode == wave.Mode.VIEW) {
			return "view";
		} else if (mode == wave.Mode.EDIT) {
			return "edit";
		} else if (mode == wave.Mode.DIFF_ON_OPEN) {
			return "diff_on_open";
		} else if (mode == wave.Mode.PLAYBACK) {
			return "playback";
		} else {
			return "unknown";
		}
	},

	
	/**
	 * translate wave.State to generic object, so that the generic object can be passed to flex.  
	 */
	unboxState: function(state) {
		var obj = {};  
		var keys = state.getKeys();
		for (var i=0; i < keys.length; ++i) {
			var key = keys[i];
			obj[key] = state.get(key);
		}
		return obj;
	},
	
	/**
	 * translate array of wave.Participant objects to generic objects, so that the generic object can be passed to flex.     
	 */
	unboxParticipants: function(participants) {
		var objs = [];
		for (var i = 0; i < participants.length; ++i) {
			var obj = nextgenapp.wave.gadget.unboxParticipant(participants[i]);
			objs.push(obj);
		}
		return objs;
	},
	
	/**
	 * translate wave.Participant to generic object, so that the generic object can be passed to flex.     
	 */
	unboxParticipant: function(participant) {
		var obj = null;
		if (participant) {
			obj = {};
			obj.id_ = participant.getId();
			obj.displayName_ = participant.getDisplayName();
			obj.thumbnailUrl_ = participant.getThumbnailUrl();
		}
		return obj;
	},
	
	/*
	* Flash doesn't properly auto coerce an AS Object to a Javascript 
	* object, so instead the AS explodes the object into separate key and 
	* value arrays and sends those.  That just means this function needs to 
	* rebuild the delta object before calling the Wave API
	*
	* see: http://code.google.com/p/napkin-wave-gadget/source/browse/trunk/html-template/js/waveFlashBridge.js
	*/
	waveStateSubmitDelta: function (keys,values) {
    	var length = keys.length;
    	var delta = {};
    	for(var i = 0; i < length; i++) {
        	delta[keys[i]] = values[i];
    	}
    	wave.getState().submitDelta(delta);
	}
}