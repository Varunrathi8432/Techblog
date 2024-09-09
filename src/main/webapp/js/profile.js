document.addEventListener("DOMContentLoaded",function(){
	let editstatus=true;
	document.getElementById('profile-edit-btn').addEventListener("click",function(){
		if(editstatus){
						
			document.getElementById('img-div').style.display="none";
			document.getElementById('profile-edit').style.display="block";
			document.getElementById('profile-detail').style.display="none";	
					
			editstatus=false;
			this.textContent="Back";
			
		}else{
	
			document.getElementById('img-div').style.display="block";
			document.getElementById('profile-edit').style.display="none";
			document.getElementById('profile-detail').style.display="block";
			
			editstatus=true;
			this.textContent="Edit";
		}
	});
});
