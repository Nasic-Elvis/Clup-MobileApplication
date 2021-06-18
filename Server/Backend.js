const mysql = require('mysql');
const express = require('express');
var bodyParser = require('body-parser');
const { response } = require('express');

const app = express();

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'admin',
    database : 'clup_engsw2020',
    timezone : "+00:00",
    multipleStatements: true
});

connection.connect(function(err) {
    if (err) throw err;
        console.log("Connected!");
        results = [];

 });

 app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/getStores', function(request, response){
    connection.query('SELECT * FROM Store', function(error, results, fields){
        if(error){
            throw error;
        }
        
        console.log(results);
        if(results.length > 0){
            response.json(results);
        }
        else{
            response.json({result:'KO'});
        }
        response.end();
    });
});


app.post('/getFavorites', function(request, response){
    var idUser = request.body.idUser;
    console.log(idUser);
    if(idUser)
{    connection.query('SELECT * FROM store INNER JOIN favorites ON store.idStore = favorites.idStore WHERE idUser=?', [idUser], function(error, results, fields){
        if(error){
            throw error;
        }
        
        console.log(results);
        if(results.length > 0){
            response.json(results);
        }
        else{
            response.json({result:'KO'});
        }
        response.end();
    });}
});

app.post('/login', function(request, response) {
    var username = request.body.username;
    var password = request.body.password;
    console.log(request.body);
    console.log("Username: " + username);
    console.log("Passowrd: " + password);
    //var t = encrypt(password);
    //console.log("Passoord crypted: " + encrypt(password));
    //console.log("Passoord decrypted: " + decrypt(t));

    if (username && password) {
        
        connection.query('SELECT * FROM user WHERE Username = ? AND Password = ?', [username, password], function(error, results, fields) {
            if(error){
                throw error;
            }
            console.log(results);
            
            if (results.length > 0) {
                response.json({result:"OK", name:results[0].Name, id:results[0].idUser, surname : results[0].Surname, email: results[0].Email, birthdayDate : results[0].BirthdayDate, telephoneNumber : results[0].TelephoneNumber});
            } else {
                response.json({result:"KO"});
            }
            response.end();
        });
    } else {
        response.send('Please enter Username and Password!');
        response.end();
    }
});


app.post('/storeInCity', function(req,res)
{
    var city = req.body.city;
    console.log(city)

    if(city){
        connection.query('SELECT * FROM store WHERE city = ?', [city], function(error, result) {
            if(error){
                throw error;
            }
            console.log(result);

            if(result.length > 0){
                res.json({result: 'OK', name: result.name, id: result.id, capacity: result.capacity});
            }
            else{
                res.json({result:'KO'});
            }
        })
    }
    else{
        res.send('Please enter a valid city');
        res.end();
    }
});

app.delete('/deleteFavorite', function(request, response){
    var idStore = request.body.idStore;
    var idUser = request.body.idUser;
    console.log(idStore);
    if(idStore){
        connection.query('DELETE FROM favorites WHERE idUser = ? AND  idStore=?', [idUser, idStore], function(error, results, fields){
            if(error){
                throw error;
            }
            console.log(results);
            response.json({result: "OK"});
            response.end();
        })
    }
    else{
        response.json({result: "KO"});
        response.end();
    }
})

app.post('/signUp', function(request, response){
    var name = request.body.name;
    var surname = request.body.surname;
    var birthdayDate = request.body.birthdayDate;
    var telephoneNumber = request.body.telephoneNumber;
    var email = request.body.email;
    var password = request.body.password;
    console.log(name);
    console.log(surname);
    console.log(telephoneNumber);
    console.log(email);
    console.log(password);
    //var t = encrypt(password);
    //console.log("Passoord crypted: " + encrypt(password));
    //console.log("Passoord decrypted: " + decrypt(t));
    if(name && surname  && telephoneNumber 
        && email && password)
        {
            connection.query("INSERT INTO user(Name, Surname, TelephoneNumber, Email, Username, Password) VALUES(?, ?, ?, ?, ?, ?)",
            [name, surname, telephoneNumber, email, email, password], function(error, results, fields){
                if(error){
                    throw error;
                }
                console.log(results);
                response.json({result: "OK"});
                response.end();
            })
        }
        else{
            response.json({result: "KO"});
            response.end();
        }
});

app.post('/insertFavorites', function(request, response){
    var idUser = request.body.idUser;
    var idStore = request.body.idStore;
    console.log(idUser);
    console.log(idStore);
    if(idUser && idStore)
        {
            connection.query("INSERT INTO favorites(idStore,idUser) VALUES(?,?)",
            [idStore,idUser], function(error, results, fields){
                if(error){
                    throw error;
                }
                console.log(results);
                response.json({result: "OK"});
                response.end();
            })
        }
        else{
            response.json({result: "KO"});
            response.end();
        }
});

app.post('/storeCapacity', (req,res) => {
    var idStore = req.body.idStore;
    console.log(idStore);
    if(idStore){
        connection.query('SELECT capacity FROM store WHERE idStore = ?', [idStore], function(error,results,fields){
            if(error){
                throw error;
            }
            if(results>0){
            res.json({result:'OK', capacity:results[0].capacity});
            }
            else{
                res.json({result:'KO'});
            }
        })
    }
})

app.post('/storeByCategory', (req,res) => {
    var category = req.body.category;
    console.log(category);
    if(category){
        connection.query('SELECT * FROM store WHERE category = ?', [category], function(error,results,fields){
            if(error){
                throw error;
            }
            console.log(results);
            if(results.length>0){
                res.json(results);
            }
            else {
                res.json({result:'KO'});
            }
        })
    }
})


 app.post('/getTime', (req, res) =>{
     var idStore = req.body.idStore;
     console.log(req.body);
     console.log(idStore);
     if(idStore){
        connection.query('select * from days INNER JOIN storeindays on iddays = idDay WHERE idStore = ?;', [idStore], function(error,results,fields){
            if(error){
                throw error;
            }
            console.log(results);
            if(results.length>0){
                res.json(results);
            }
            else {
                res.json({result:'KO'});
            }
        })
    }
 })

 


 app.post('/booking', (req,res) => {
    var idStore = req.body.idStore;
    var idUSer = req.body.idUser;
    var date = req.body.date;
    var time = req.body.time;
    console.log(idStore);
    console.log(idUSer);
    console.log(date);
    console.log(console);

    if(idStore && idUSer && date && time){
        connection.query('INSERT INTO booking(bookingDate, ArrivalTime, idUSer, idStore) VALUES(?, ?, ?, ?)', 
        [date, time, idUSer, idStore], function(error,results,fields){
            if(error){
                throw error;
            }
            if(results.affectedRows>0){
            res.json({result:'OK'});
            }
            else{
                res.json({result:'KO'});
            }
        })
    }
})

app.get('/index', (req,res) => {
    res.send('Hello World');
})

app.get('/bookings', (req,res) => {
    res.send([1,2,3]);
})

app.listen(3000, () => console.log('Listening on port 3000'));