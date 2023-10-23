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
  var query = "SELECT software_name, software_supplier FROM software";
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
  var subjectName = req.body.subject_name;

  // Update the query based on the relationship between subject, class, and room in your DB
  var query = `SELECT r.room_number, b.Building_name 
               FROM room r 
               JOIN class c ON r.room_id = c.room_id 
               JOIN subject s ON c.subject_code = s.subject_code 
               JOIN building b ON r.building_id = b.Building_id 
               WHERE s.Subject_name = "${subjectName}"`;

  useQuery(query, req, res);
});

router.post('/studentCount', function(req, res, next) {
  var subjectName = req.body.subject_name;
  var query = `SELECT student_enrol FROM subject WHERE Subject_name = "${subjectName}"`;

  useQuery(query, req, res);
  console.log("Query used:", query);
});

module.exports = router;
