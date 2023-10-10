var express = require('express');
var router = express.Router();

/* Function to connect to DB and use query*/
function useQuery(query,req,res) {
  
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
  console.log("buildings has been called");
  var query = "SELECT Building_id, Building_name FROM building";
  useQuery(query,req,res);
});


module.exports = router;
