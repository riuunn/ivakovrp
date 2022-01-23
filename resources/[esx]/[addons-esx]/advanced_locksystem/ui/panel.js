var currentCode = "";
var audioPlayer = null;
var door_index = "";
var door_hacked = "";
var door_locked = "";
var door_code = "";

/*------------------------*/
var door1Info = "";
var door2Info = "";
var text_coords;

$(document).ready(function(){  

    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Howl({src: ["sound3.mp3"]});
    audioPlayer.volume(50.0);
    
    $("#key1").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "1";
    }); 
    $("#key2").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "2";
    }); 
    $("#key3").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "3";
    }); 
    $("#key4").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "4";
    }); 
    $("#key5").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "5";
    }); 
    $("#key6").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "6";
    }); 
    $("#key7").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "7";
    }); 
    $("#key8").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "8";
    }); 
    $("#key9").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "9";
    }); 
    $("#key0").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "0";
    }); 

    $("#keyCancel").click(function(){
        audioPlayer.play();
        $('#panel-holder').css('display', "none")
		$('body').css('display', "none")
        $.post('http://advanced_locksystem/escape', JSON.stringify({}));
    }); 

    $("#keyClear").click(function(){
        audioPlayer.play();
        currentCode = "";
    });

    $("#keyEnter").click(function(){
        audioPlayer.play();
		$('#panel-holder').css('display', "none")
		$('body').css('display', "none")
        $.post('http://advanced_locksystem/try', JSON.stringify({
            inserted_code: currentCode,
			doorindex : door_index,
			locked : door_locked,
			hacked : door_hacked,
			pincode : door_code
        }));

        currentCode = "";        
    });
	
	$("#authorized_jobs").on('change', function(){
		if($("#authorized_jobs").val().trim().length > 0){
			$("#authorized_jobs").removeClass('error')
		}
	});
	
	$("#size").on('change', function(){
		if($("#size").val().trim().length > 0){
			var temp = $("#size").val().trim()
			if($.isNumeric(temp)){
				$("#size").removeClass('error')
			}
		}
	});
	
	$("#distance").on('change', function(){
		if($("#distance").val().trim().length > 0){
			var temp = $("#distance").val().trim()
			if($.isNumeric(temp)){
				$("#distance").removeClass('error')
			}
		}
	});
	
	$("#submit").click(function(){
		event.preventDefault(); // Prevent form from submitting
		var error = false
		var authorized_jobs = $("#authorized_jobs").val();
		authorized_jobs = authorized_jobs.replace(/\s/g, '');

		if(authorized_jobs.length == 0){
			error = true
			$("#authorized_jobs").addClass('error')
		}
		var isgate = $('#isgate_0').is(":checked");
		var pincode = $('#pincode').val().trim();
		
		var unlockable = $('#unlockable_0').is(":checked");
		var locked = $('#locked_0').is(":checked");
		var size = $('#size').val().trim();
		
		if(!size){
			size = 1;
		}
		else{
			if($.isNumeric(size)){
			}
			else {
				error = true
				$('#size').addClass('error')
			}
		}
		
		var distance = $('#distance').val().trim();
		if(!distance){
			distance = 1.5;
		}
		else {
			if($.isNumeric(distance)){
			}
			else {
				error = true
				$('#distance').addClass('error')
			}		
		}

		if(error == false){
			$("form")[0].reset();
			$.post('http://advanced_locksystem/makingdoor', JSON.stringify({
				door1Info: door1Info,
				door2Info : door2Info,
				textCoords : text_coords,
				locked : door_locked,
				authorized_jobs : authorized_jobs,
				isgate : isgate,
				pincode : pincode,
				unlockable : unlockable,
				locked : locked,
				size : size,
				distance : distance
			}));
			
			$('body').css('display', "none")
			$('#door-form').css('display', "none")
		}		
		
	});
	
	$("#cancel").click(function(){
		$('body').css('display', "none")
		$('#door-form').css('display', "none")
		$.post('http://advanced_locksystem/cancelmakingdoor', JSON.stringify({}));
	});
	
	
    window.addEventListener('message', function(event) {
        var data = event.data;
        
        if (event.data.type == "enableui") {
		
			currentCode = "";
			door_index = event.data.doorindex
			door_hacked = event.data.hacked
			door_locked = event.data.locked
			door_code = event.data.pincode
			
			$('body').css('display', event.data.enable ? "block" : "none")
            $('#panel-holder').css('display', event.data.enable ? "block" : "none")
        }
		else if(event.data.type == "createdoor") {
			door1Info = event.data.door1;
			door2Info = event.data.door2;
			text_coords = event.data.textCoords
			$('body').css('display', event.data.enable ? "block" : "none")
			$('#door-form').css('display', event.data.enable ? "block" : "none")
		}
    });
	
	function isNumber(e) {
		var key=e.which || e.KeyCode;
		if ( key >=48 && key <= 57) {
			return true; 
		}
		else {
			return false;
		}
	}	
	
});