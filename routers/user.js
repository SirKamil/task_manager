const bcrypt = require('bcrypt');
const {ValidationError} = require("../utils/errors");
const {TaskRecord} = require("../records/client/task.record");
const {UserRecord} = require("../records/client/user.record");
const {Router} = require("express");
const userRouter = Router();

userRouter
    .get('/', (req,res) => {
        res.render('users/login')
    })

    .post('/', async (req, res) => {
         const user = await UserRecord.getOne(req.body.login);
         // console.log(req.body, user.id);

         if(user === null){
             throw new ValidationError('cannot find user')
         }

        if (await bcrypt.compare(req.body.password, user.pwdhash)) {
            res.redirect(`/login/user/${user.id}`)
        } else {
            throw new ValidationError('not allowed')
        }

    })

    .get('/user/:id', async (req,res) => {
        const taskList = await TaskRecord.userTaskList(req.params.id)
        // console.log(taskList)
        res.render('users/user',{
            id: req.params.id,
            taskList,
        })
    })

    .post('/user/:id', async (req,res) => {

        const newTask = new TaskRecord({
            taskName: req.body.name,
            userID: req.params.id,
        });
        await newTask.insert()
        // console.log(newTask)
        res.redirect(`/login/user/${req.params.id}`)

    })

    .delete('/user/:userId/:taskId', async (req,res) => {
        const getOne = await TaskRecord.getOne(req.params.taskId)
        console.log(req.params.taskId)
        const soonDeleted = new TaskRecord(getOne);
        await soonDeleted.delete(req.params.taskId)
        res.redirect(`/login/user/${req.params.userId}`)

    })

    .get('/register', (req,res) => {
        res.render('users/register')
    })

    .post('/register', async (req, res) => {
        // console.log(req.body);

        const pwdHash = await bcrypt.hash(req.body.password, 6);
        const data = {login: req.body.login, password: pwdHash};
        const newUser = new UserRecord(data);
        const registration = await newUser.register()
        res.render('users/success-registration',{
            name: req.body.login,
        })


    })



module.exports = {
   userRouter,
};