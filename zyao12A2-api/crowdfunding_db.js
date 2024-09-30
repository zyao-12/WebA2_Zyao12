//introduce the dependencies.
const express = require('express');
const cors = require('cors');
const mysql = require('mysql');

const app = express();
//set port number: 3000
const port = 3000;

// set the cors settings to avoid the cors error.
app.use(cors());

// create the database connection using mysql5.7
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12345678',
    database: 'crowdfunding_db'
});

// get request: return all fundraisers using the following SQL.
app.get('/fundraisers', (req, res) => {
    const getAllSQL = 'SELECT * FROM FUNDRAISER WHERE ACTIVE = 1';
    db.query(getAllSQL, (err, results) => {
        if (err) {
            //return the error to the console.
            return res.status(500).json({ error: err });
        }
        res.json(results);
    });
});

// get request: get detailed information of specific fundraiser by using the URL parameter.
app.get('/fundraiser/:id', (req, res) => {
    const detailedSQL = 'SELECT * FROM FUNDRAISER WHERE FUNDRAISER_ID = ?';
    db.query(detailedSQL, [req.params.id], (err, results) => {
        if (err || results.length === 0) {
            return res.status(404).json({ error: 'Not found' });
        }
        res.json(results[0]);
    });
});

// get request: search the organizer, city, category in the query input controllers.
// this function supports partial search.
app.get('/search', (req, res) => {
    const { organizer, city, category } = req.query;
    let query = 'SELECT * FROM FUNDRAISER WHERE ACTIVE = 1';
    let conditions = [];

    if (organizer) {
        conditions.push(`ORGANIZER LIKE '%${organizer}%'`);
    }
    if (city) {
        conditions.push(`CITY LIKE '%${city}%'`);
    }
    if (category) {
        conditions.push(`CATEGORY_ID = (SELECT CATEGORY_ID FROM CATEGORY WHERE NAME = '${category}')`);
    }

    if (conditions.length > 0) {
        query += ' AND ' + conditions.join(' AND ');
    }

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err });
        }
        res.json(results);
    });
});

// run the server.
app.listen(port, () => {
    console.log(`Port: ${port}`);
});
