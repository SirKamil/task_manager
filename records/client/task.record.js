const {ValidationError} = require("../../utils/errors");
const {pool} = require("../../utils/db");
const {v4: uuid} = require('uuid');

class TaskRecord {

    constructor(obj) {
        if (!obj.taskName , obj.taskName.length <3 , obj.taskName.length > 100){
            throw new ValidationError('Task description between 3 and 100 marks ')
        }

        this.name = obj.taskName;
        this.taskID = obj.taskID;
        this.userID = obj.userID;
    }

    async insert() {
        if (!this.taskID){
            this.taskID = uuid();
        }

        pool.execute('INSERT INTO `tasks` VALUES(:taskName, :userID, :taskID)',{
            taskName: this.name,
            userID: this.userID,
            taskID: this.taskID,
        })
    }

    static async userTaskList(id) {
       const [results] = await pool.execute('SELECT * FROM `tasks` WHERE `userID` = :id', {
           id,
       });
       // console.log(results)
        return results.length === 0 ? null : results;
    };

    async delete(taskID) {
        pool.execute('DELETE FROM `tasks` WHERE `taskID` = :taskID',{
            taskID,
        })
    }

    static async getOne(taskId) {
        const [results] = await pool.execute('SELECT * FROM `tasks` WHERE `taskID` = :taskId',{
            taskId,
        });
        return results.length === 0 ? null : results[0];
        console.log(results[0])
    };
};

module.exports = {
    TaskRecord,
}