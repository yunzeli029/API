<?php

/**
 * Handling database connection
 *
 * @author Ravi Tamada
 * @link URL Tutorial link
 */
class DbConnect {

    private $conn;

    function __construct() {
    }

    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect() {
        include_once dirname(__FILE__) . '/Config.php';
        $conn_string = "host=".DB_HOST." port=".DB_PORT." dbname=".DB_NAME." user=".DB_USERNAME." password=".DB_PASSWORD;
        // Connecting to mysql database
        $this->conn = pg_connect($conn_string);

        // Check for database connection error
        if (!$this->conn) {
            echo "Failed to connect to PostgreSQL: " . pg_last_error();
        }

        // returing connection resource
        return $this->conn;
    }

}

?>
