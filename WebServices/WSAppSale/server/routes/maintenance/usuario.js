const express = require('express');
var db = require('../../sql/maintenanceSQL/usuarioSQL');
const bcrypt = require('bcrypt')
const app = express();

app.post('/Api/v1/UserAdmin', (req, res) => {
    let Query = 'SI_UserAdmin';
    let body = req.body;

    async function hashPassword(password) {
        const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(password, salt)
        // console.log(hash)   

        params = {
            Name: body.Name,
            LastName: body.LastName,
            BussinesName: body.BussinesName,
            Ruc: body.Ruc,
            Direction: body.Direction,
            City: body.City,
            Country: body.Country,
            Dni: body.Dni,
            Phone: body.Phone,
            EmailCompany: body.EmailCompany,      
            TypePersonId: body.TypePersonId,
            EmailAdmin: body.EmailAdmin,
            DirectionAdmin: body.DirectionAdmin,
            CityAdmin: body.CityAdmin,
            CountryAdmin: body.CountryAdmin,
            User_at: body.User,
            Hash_at: hash
        };

        db.executeSql(Query, params, 'RegisterUserAdmin', (hashResponse, err) => {
            if (err) {
                return res.status(500).json({
                    status: false,
                    response: err
                });
            };
            if (hashResponse[0]['Response'] == 'Compania ya Existe') {
                console.log(hashResponse[0]['Response']);
                return res.status(400).json({
                    status: false,
                    response: 'Compania ya Existe.'
                });
            }

            res.json({
                status: true,
                response: hashResponse[0].Response
            });
        });
    }

    hashPassword(body.Password);

});
app.post('/Api/v1/UserSeller', (req, res) => {
    let Query = 'SI_UserSeller';
    let body = req.body;

    async function hashPassword(password) {
        const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(password, salt)        
        params = {
            Name: body.Name,
            LastName: body.LastName,
            Direction: body.Direction,
            City: body.City,
            Country: body.Country,
            Dni: body.Dni,
            Phone: body.Phone,
            Email: body.Email,
            TypePersonId: body.TypePersonId,
            User_at: body.User,
            Hash_at: hash
        };

        db.executeSql(Query, params, 'RegisterUserSeller', (hashResponse, err) => {
            if (err) {
                return res.status(500).json({
                    status: false,
                    response: err.message
                });
            };
            res.json({
                status: true,
                response: hashResponse[0].Response
            });
        });
    }

    hashPassword(body.Password);

});

//Configuraciones de Google

module.exports = app;