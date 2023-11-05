

/*---------------FILLING ON BEHALF OF SOMEONE ELSE----------------*/
function toggleTextbox() {
    var checkBox = document.getElementById('onBehalfCheckbox');
    var input = document.getElementById('e13581');
    if (checkBox.checked) {
        input.style.display = 'block';
        input.readOnly = false;
    } else {
        input.style.display = 'none';
        input.value = ''; 
    }
}
/*------------------------------------------------------------------*/









/*---------------------SUBJECT AREA, Subject, Number of Users, Adding Rooms---------------------*/
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
    
        subjectAreas.forEach(function(sbj) {
            var searchTerm = inputValue.toLowerCase();

            if (sbj.toLowerCase().indexOf(searchTerm) !== -1) {
                var resultDiv = document.createElement('div');
                resultDiv.textContent = sbj;
                resultDiv.onclick = function() {
                    var inputField = document.getElementById('e13602');
                    inputField.value = sbj;
                    results.style.display = 'none';
                    subSectionInput.disabled = false;
                };
                results.appendChild(resultDiv);
            }
        });

        results.style.display = results.children.length > 0 ? 'block' : 'none';
    });
});

document.getElementById('subSection').addEventListener('input', function() {
    var results = document.getElementById('subjectResults');
    var selectedSubjectArea = document.getElementById('e13602').value;  
    var inputUsers = document.getElementById('e13611');
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

                        //Clear the rooms list
                        var clearRoomList = document.getElementById('room_list');
                        clearRoomList.innerHTML = '';
                        var roomDivs = document.getElementById('room_results').getElementsByTagName('div');
                        for (var i = 0; i < roomDivs.length; i++) {
                            roomDivs[i].style.backgroundColor = '';
                            roomDivs[i].style.border = '';
                        }

                        fetch("/studentCount", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({ subject_name: subject })
                        })
                        .then(response => response.json())
                        .then(data => {
                            inputUsers.value = data[0].student_enrol;
                        })
                        

                        //get the rooms for the selected subject
                        fetch("/roomsForSubject", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({ subject_name: subject })
                        })
                        .then(response => response.json())
                        .then(data => {
                            displayRooms(data);
                        })
                      
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

function displayRooms(rooms) {
    var roomResults = document.getElementById('room_results');
    roomResults.innerHTML = '';

    for(let room of rooms) {
        let div = document.createElement('div');
        div.innerText = room.Building_name + " - " + room.room_type + " - Room " + room.room_number;
        div.addEventListener('click', function() {
            var roomList = document.getElementById('room_list');
            var roomText = room.Building_name + " - " + room.room_type + " - Room " + room.room_number;

            var matchingLi = Array.from(roomList.querySelectorAll('li')).find(li => li.innerText.startsWith(roomText));
            
            if (matchingLi) {
                //If room is already in the list remove it
                roomList.removeChild(matchingLi);
                div.style.backgroundColor = '';  
                div.style.border = '';
            } else {
                //If room is not in the list add it
                div.style.backgroundColor = '#e0e0e0';  
                div.style.border = '1px solid #000';
        
                var li = document.createElement('li');
                li.innerText = roomText;
        
                //remove button
                var removeBtn = document.createElement('button');
                removeBtn.innerText = "Remove";
                removeBtn.addEventListener('click', function() {
                    roomList.removeChild(li);
        
          
                    div.style.backgroundColor = '';  
                    div.style.border = '';
                });
                li.appendChild(removeBtn);
        
                roomList.appendChild(li);
            }
        });
        
        roomResults.appendChild(div);
    }
    roomResults.style.display = roomResults.children.length > 0 ? 'block' : 'none';
}

document.getElementById('e13602').addEventListener('change', function() {
    //Clear subSection input
    document.getElementById('subSection').value = '';
    
    //Clear rooms list
    document.getElementById('room_list').innerHTML = '';
    

    var roomResultsDivs = document.getElementById('room_results').querySelectorAll('div');
    roomResultsDivs.forEach(function(div) {
        div.style.backgroundColor = '';  
        div.style.border = '';
    });
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
    const createNewAppBtn = document.getElementById("createNewApp");

    const applications = [];
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            const lis = this.responseText;
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

        var allApps = applications;
        for (var i = 0; i < allApps.length; i++) {
            var currentApp = allApps[i];
            var search = inputValue.toLowerCase();
            if (currentApp.software_name.toLowerCase().indexOf(search) !== -1) {
                var resultDiv = document.createElement('div');
                var versionText = currentApp.version ? " (" + currentApp.version + ")" : "";
                resultDiv.textContent = currentApp.software_name + versionText;
                
                resultDiv.onclick = function(appCopy) {
                    return function() {
                        var displayText = appCopy.software_name + (appCopy.version ? " (" + appCopy.version + ")" : "");
                        
                        appInput.value = displayText;
                        appNameInput.value = displayText; 
                        
                        resultsDiv.style.display = 'none';
                        newAppPrompt.style.display = 'none';
                        
                        if (appCopy.software_name === "Other") {
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
                            softwareSupplierInput.value = appCopy.software_supplier;
                        }
                    };
                }(currentApp);
                resultsDiv.appendChild(resultDiv);
            }
        }
        

        resultsDiv.style.display = resultsDiv.children.length > 0 ? 'block' : 'none';

        if (resultsDiv.children.length == 0 && this.value.trim() != "") {
            newAppPrompt.style.display = 'block';
        } else {
            newAppPrompt.style.display = 'none';
        }
    });

    document.addEventListener('click', function(evt) {

        if (!evt.target.closest('#e13600')) {

            resultsDiv.style.display = 'none';
            
            if (appInput.value.trim() === "") {
                newAppPrompt.style.display = 'none';
            }
        }
    });

    //"Create New Application" button click
    createNewAppBtn.addEventListener('click', function(event) {
        event.preventDefault();
    
        appNameInput.removeAttribute("disabled");
        softwareSupplierInput.removeAttribute("disabled");
        obtainingMediaTextarea.removeAttribute("disabled");
        appNameInput.value = "";
        softwareSupplierInput.value = "";
        obtainingMediaTextarea.value = "";
        appInput.value = "Other";
        resultsDiv.style.display = 'none';
        newAppPrompt.style.display = 'none';
    });
});
/*-----------------------------------------------------------------*/








