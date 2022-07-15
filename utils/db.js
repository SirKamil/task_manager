const {createPool} = require("mysql2/promise");

const pool = createPool({
    host: '0.0.0.0',
    user: 'root',
    database: 'megakurs_task-manager',
    namedPlaceholders: true,
    decimalNumbers: true,
});

module.exports = {
    pool,
};