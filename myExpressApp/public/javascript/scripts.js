

/*---------------FILLING ON BEHALF OF SOMEONE ELSE----------------*/
function toggleTextbox() {
    var checkBox = document.getElementById('onBehalfCheckbox');
    var inputField = document.getElementById('e13581');
    if (checkBox.checked) {
        inputField.style.display = 'block';
        inputField.readOnly = false;
    } else {
        inputField.style.display = 'none';
        inputField.value = ''; 
    }
}
/*------------------------------------------------------------------*/









/*---------------------SUBJECT AREA, Subject, Number of Users---------------------*/

document.getElementById('e13602').addEventListener('input', function() {
    var results = document.getElementById('subjectAreaResults');
    var subSectionInput = document.getElementById('subSection');
    
    var subjectAreas = [];
    fetch('/majors')
    .then(response => response.json())
    .then(data => {
        subjectAreas = data.map(item => item.Major_name);
    
        results.innerHTML = '';
        var inputValue = this.value.toLowerCase();
    
        for(let subject of subjectAreas) {
            if (subject.toLowerCase().includes(inputValue)) {
                let div = document.createElement('div');
                div.innerText = subject;
                div.addEventListener('click', function() {
                    document.getElementById('e13602').value = subject;
                    results.style.display = 'none';
                    subSectionInput.disabled = false;
                });
                results.appendChild(div);
            }
        }

        results.style.display = results.children.length > 0 ? 'block' : 'none';
    });
});

document.getElementById('subSection').addEventListener('input', function() {
    var results = document.getElementById('subjectResults');
    var selectedSubjectArea = document.getElementById('e13602').value; 
    var inputFieldUsers = document.getElementById('e13611');
    var inputValue = document.getElementById('subSection').value.toLowerCase();

    var subjects = [];
    var selected_subject = {"subject_name": selectedSubjectArea};

    let ahttp = new XMLHttpRequest();
    ahttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            const lis = this.responseText;
            const subs = JSON.parse(lis);
            for (let i of subs) {
                subjects.push(i.Subject_name);
            }

            results.innerHTML = '';

            for(let subject of subjects) {
                if (subject.toLowerCase().includes(inputValue)) {
                    let div = document.createElement('div');
                    div.innerText = subject;
                    div.addEventListener('click', function() {
                        document.getElementById('subSection').value = subject;
                        results.style.display = 'none';


                        fetch("/studentCount", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({ subject_name: subject })
                        })
                        .then(response => response.json())
                        .then(data => {
                            inputFieldUsers.value = data[0].student_enrol;
                        })
                        .catch(error => console.error('Error:', error));
                    });
                    results.appendChild(div);
                }
            }
            results.style.display = results.children.length > 0 ? 'block' : 'none';
        }
    };

    ahttp.open("POST", "/subjects", true);
    ahttp.setRequestHeader("Content-type", "application/json");
    ahttp.send(JSON.stringify(selected_subject));
});
/*------------------------------------------------------------------*/







/*--------Selecting Application and Autofilling App name, Software Supplier, Obtaining -------------------------*/

	document.addEventListener("DOMContentLoaded", function() {
		const appInput = document.getElementById("e13600");
		const resultsDiv = document.getElementById("appResults");
		const appNameInput = document.getElementById("e13601");
		const softwareSupplierInput = document.getElementById("e13595");
		const obtainingMediaTextarea = document.getElementById("e13587");
		const newAppPrompt = document.getElementById('newAppPrompt');

		const applications = [];
		let xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function () {
			if (this.readyState == 4 && this.status == 200) {
				const lis = this.responseText
				const software_list = JSON.parse(lis);
				for (let i of software_list) {
					applications.push(i);
					console.log(i.software_name);
				}
			}
		};

		xhttp.open("GET", "/softwares", true);
        xhttp.send();

		appInput.addEventListener('input', function() {
			const inputValue = this.value.toLowerCase();
			resultsDiv.innerHTML = '';

			for (let app of applications) {
				if (app.software_name.toLowerCase().includes(inputValue)) {
					let div = document.createElement('div');
					div.innerText = app.software_name;
					div.addEventListener('click', function() {
						appInput.value = app.software_name;
						resultsDiv.style.display = 'none';
						newAppPrompt.style.display = 'none';

						if (app.software_name === "Other") {
							appNameInput.removeAttribute("disabled");
							softwareSupplierInput.removeAttribute("disabled");
							obtainingMediaTextarea.removeAttribute("disabled");
							appNameInput.value = "";
							softwareSupplierInput.value = "";
							obtainingMediaTextarea.value = "";
						} else {
							appNameInput.setAttribute("disabled", "disabled");
							softwareSupplierInput.removeAttribute("disabled");
							obtainingMediaTextarea.removeAttribute("disabled");
							appNameInput.value = app.software_name;
							softwareSupplierInput.value = app.software_supplier;
							obtainingMediaTextarea.value = app.media;
						}
					});
					resultsDiv.appendChild(div);
				}
			}

			resultsDiv.style.display = resultsDiv.children.length > 0 ? 'block' : 'none';


			if (resultsDiv.children.length == 0 && this.value.trim() != "") {
				newAppPrompt.style.display = 'block';
			} else {
				newAppPrompt.style.display = 'none';
			}
		});

		document.addEventListener('click', function(event) {
			if (!event.target.closest('#e13600')) {
				resultsDiv.style.display = 'none';
				if (appInput.value.trim() == "") {
					newAppPrompt.style.display = 'none';
				}
			}
		});
	});

/*-----------------------------------------------------------------*/










/*-------------------Adding Rooms---------------------------------------------*/
document.addEventListener("DOMContentLoaded", function() {
    const roomListButton = document.getElementById("room_list_button");
    const roomResultsDiv = document.getElementById("room_results");
    const roomListUl = document.getElementById("room_list");


    let rooms = [];

    function roomAlreadyAdded(room) {
        const existingItems = roomListUl.querySelectorAll("li");
        for (let item of existingItems) {
            if (item.firstChild.nodeValue === room) { 
                return true;
            }
        }
        return false;
    }
    

    function addRoomToList(room) {

        if (roomAlreadyAdded(room)) {
            return;
        }
    
        const li = document.createElement("li");
        li.textContent = room;
    
        const removeBtn = document.createElement("button");
        removeBtn.textContent = "Remove";
        removeBtn.onclick = function() {
            roomListUl.removeChild(li);
            renderRoomList();  
        };
    
        li.appendChild(removeBtn);
        roomListUl.appendChild(li);
    }

    function renderRoomList() {
        roomResultsDiv.innerHTML = '';

        rooms.forEach(room => {
            const resultDiv = document.createElement("div");
            resultDiv.textContent = room;
            
            if (roomAlreadyAdded(room)) {
                resultDiv.style.opacity = "0.5";
                resultDiv.style.pointerEvents = "none";  
            } else {
                resultDiv.onclick = function() {
                    addRoomToList(room);
                    renderRoomList();  
                };
            }

            roomResultsDiv.appendChild(resultDiv);
        });
    }


    fetch("/rooms")
    
    .then(response => response.json())
    .then(data => {
 
        rooms = data.map(item => item.Building_name + " - Room " + item.room_number);

        roomListButton.addEventListener("click", function(event) {
            event.preventDefault();
            renderRoomList();
        });
    });

});
/*------------------------------------------------------------------*/
