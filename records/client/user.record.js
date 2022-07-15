const {pool} = require("../../utils/db");
const {v4: uuid} = require('uuid');
const {ValidationError} = require("../../utils/errors");


class UserRecord {

    constructor(obj) {
        if (!obj.login || obj.login.length <3 || obj.login.length > 25){
            throw new ValidationError('Login between 3 and 25 marks')

        }

        this.login = obj.login;
        this.password = obj.password;
        this.id = obj.id;

    }

    async register() {
        if (!this.id){
            this.id = uuid();
        }

        const [result] = await pool.execute('SELECT * FROM `users` WHERE `login` = :login', {
            login: this.login
        })
        // console.log(result);

        if(result.length !== 0) {
            throw new ValidationError('Login already exists')

        } else {
            pool.execute('INSERT INTO `users` VALUES(:id, :login, :pwdhash)',{
                id: this.id,
                login: this.login,
                pwdhash: this.password,
            })

            return true
        }

    }

    static async getOne(login) {
        const [results] = await pool.execute('SELECT * FROM `users` WHERE `login` = :login',{
            login,
        });
        return results.length === 0 ? null : results[0];
    };

}

module.exports = {
    UserRecord,
}