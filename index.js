const express = require('express');
require('express-async-errors');
const methodOverride = require('method-override');
require('./utils/db');
const {ValidationError} = require("./utils/errors");
const {homeRouter} = require("./routers/home");
const {userRouter} = require("./routers/user");
const {engine} = require('express-handlebars');
const {handleError} = require("./utils/errors");



const app = express();

app.use(methodOverride('_method'));
app.use(express.urlencoded({
    extended: true,
}));
app.use(express.static('public'));
app.use(express.json()); //Content-type: application/json

app.engine('.hbs', engine({
    extname: '.hbs',
    // helpers: handlebarsHelpers,
}));
app.set('view engine', '.hbs');

app.use('/', homeRouter);
app.use('/login', userRouter);


app.use(handleError);


app.listen(3001, '0.0.0.0', () => {
    console.log('Listening on http://localhost:3001 ')
});

