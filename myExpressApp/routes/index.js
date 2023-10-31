var express = require('express');
var router = express.Router();

/* Function to connect to DB and use query*/
function useQuery(query,req,res) {
  console.log("Query:    " + query);
  req.pool.getConnection( function(err,connection) {
    if (err) {
      console.log(err);
      res.sendStatus(500);
      return;
    }

    connection.query(query, function(err, rows, fields) {
      connection.release(); // release connection
      if (err) {
        console.log(err);
        res.sendStatus(500);
        return;
      }
      res.json(rows);
    });
  });
}

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/buildings', function(req, res, next) {
  var query = "SELECT Building_id, Building_name FROM building";
  useQuery(query,req,res);
});

router.get('/subjectAreas', function(req, res, next) {
  var query = "SELECT Major_name FROM major";
  useQuery(query,req,res);
});

router.post('/subjects', function(req, res, next) {

  const lettersAndNumbersPattern = /^[A-Za-z0-9 ]+$/;

  if(!req.body.subject_name.match(lettersAndNumbersPattern)){
    return res.status(400).json({ err: "No special characters please!"})
  }

  var query = "SELECT Major_id FROM major WHERE Major_name = " + "\"" + req.body.subject_name + "\"";
  req.pool.getConnection( function(err,connection) {
    if (err) {
      console.log(err);
      res.sendStatus(500);
      return;
    }

    connection.query(query, function(err, rows, fields) {
      connection.release();
      if (err) {
        console.log(err);
        return;
      }
      console.log(rows);
      query = "SELECT Subject_name FROM subject WHERE Major_id = " + rows[0].Major_id;
      useQuery(query,req,res);

    });
  });
  
});

router.get('/softwares', function(req, res, next) {
  var query = `
    SELECT s.software_name, s.software_supplier, sv.version 
    FROM software s 
    LEFT JOIN softwareversion sv ON s.software_id = sv.software_id
  `;
  useQuery(query,req,res);
});

router.get('/majors', function(req, res, next) {
  var query = "SELECT Major_name FROM major";
  useQuery(query,req,res);
});

router.get('/rooms', function(req, res, next) {
  var query = "SELECT r.room_number, b.Building_name FROM room r JOIN building b ON r.building_id = b.Building_id";
  useQuery(query, req, res);
});

router.get('/room', function(req, res, next) {
  var query = "SELECT r.room_number, b.Building_name FROM room r JOIN building b ON r.building_id = b.Building_id";

  useQuery(query, req, res);
});
router.post('/roomsForSubject', function(req, res, next) {

  const lettersAndNumbersPattern = /^[A-Za-z0-9 ]+$/;

  if(!req.body.subject_name.match(lettersAndNumbersPattern)){
    return res.status(400).json({ err: "No special characters please!"})
  }

  var subjectName = req.body.subject_name;
  var query = `
      SELECT DISTINCT r.room_number, r.room_type, b.Building_name 
      FROM room r 
      JOIN building b ON r.building_id = b.Building_id
      JOIN class c ON c.room_number = r.room_number
      WHERE c.Subject_code = (SELECT Subject_code FROM subject WHERE Subject_name = "${subjectName}");
  `;
  useQuery(query, req, res);
});


router.post('/studentCount', function(req, res, next) {
  const lettersAndNumbersPattern = /^[A-Za-z0-9 ]+$/;

  if(!req.body.subject_name.match(lettersAndNumbersPattern)){
    return res.status(400).json({ err: "No special characters please!"})
  }
  
  var subjectName = req.body.subject_name;
  var query = `SELECT student_enrol FROM subject WHERE Subject_name = "${subjectName}"`;

  useQuery(query, req, res);
  console.log("Query used:", query);
});

module.exports = router;
