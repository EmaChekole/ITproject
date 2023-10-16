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
  //should get called every time when the page loads
  var query = "SELECT Major_name FROM major";
  useQuery(query,req,res);
});

router.get('/subjects', function(req, res, next) {
  //called when user selects a subject area. 
  //this will return all subjects in that subject area

  //var query = "SELECT Subject_name FROM subject WHERE Major_id = " + String(req);
  var query = "SELECT Subject_name, student_enrol FROM subject WHERE Major_id = " + "1"; //temporary until client javascript is implemented
  useQuery(query,req,res);
});

router.get('/softwares', function(req, res, next) {
  //should get called every time to show all available software
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

module.exports = router;
