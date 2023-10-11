

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

    var subjectAreas = ['COMP SCI - Computer Science'];

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

document.getElementById('subSection').addEventListener('input', function() {
    var results = document.getElementById('subjectResults');
    var subjectAreas = document.getElementById('e13602').value;
    var inputFieldUsers = document.getElementById('e13611');

    var subjects = [];
    if (subjectAreas === 'COMP SCI - Computer Science') {
        subjects = ['Information Technology Project', 'Statistical Machine Learning'];
    }

    results.innerHTML = '';
    var inputValue = this.value.toLowerCase();

    for(let subject of subjects) {
        if (subject.toLowerCase().includes(inputValue)) {
            let div = document.createElement('div');
            div.innerText = subject;
            div.addEventListener('click', function() {
                document.getElementById('subSection').value = subject;
                results.style.display = 'none';


                switch (subject) {
                    case 'Information Technology Project':
                        inputFieldUsers.value = '150';
                        break;
                    case 'Statistical Machine Learning':
                        inputFieldUsers.value = '200';
                        break;
                    default:
                        inputFieldUsers.value = '';
                        break;
                }
            });
            results.appendChild(div);
        }
    }

    results.style.display = results.children.length > 0 ? 'block' : 'none';
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
		//applications.push(JSON.parse([{"software_name":"other","software_supplier":""}]));

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
		const roomSearchInput = document.getElementById("room_search");
		const roomResultsDiv = document.getElementById("room_results");
		const roomListUl = document.getElementById("room_list");

		const rooms = [
			"Lab 1",
			"Lab 2",
			"Lab 3",
		];

		roomSearchInput.addEventListener("input", function() {
			const searchTerm = this.value.toLowerCase();
			roomResultsDiv.innerHTML = '';

			const filteredRooms = rooms.filter(room => room.toLowerCase().includes(searchTerm));

			filteredRooms.forEach(room => {
				const resultDiv = document.createElement("div");
				resultDiv.textContent = room;
				resultDiv.onclick = function() {
					if (!roomAlreadyAdded(room)) {
						addRoomToList(room);
					}
					roomSearchInput.value = '';
					roomResultsDiv.innerHTML = '';
				};
				roomResultsDiv.appendChild(resultDiv);
			});
		});

		function roomAlreadyAdded(room) {
			const existingItems = roomListUl.querySelectorAll("li");
			for (let item of existingItems) {
				if (item.textContent === room) {
					return true;
				}
			}
			return false;
		}

		function addRoomToList(room) {
			const li = document.createElement("li");
			li.textContent = room;

			
			const removeBtn = document.createElement("button");
			removeBtn.textContent = "Remove";
			removeBtn.onclick = function() {
				roomListUl.removeChild(li);
			};
			
			li.appendChild(removeBtn);
			roomListUl.appendChild(li);
		}
	});
/*------------------------------------------------------------------*/
