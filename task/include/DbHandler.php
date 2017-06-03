<?php

/**
 * Class to handle all db operations
 * This class will have CRUD methods for database tables
 *
 * @author Ravi Tamada
 * @link URL Tutorial link
 */
class DbHandler {

    private $conn;

    function __construct() {
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

    /* ------------- `users` table method ------------------ */

    /**
     * Creating new user
     * @param String $name User full name
     * @param String $email User login email id
     * @param String $password User login password
     */
    public function createUser($firstname,$lastname, $email,$username, $password) {
        require_once 'PassHash.php';
        $response = array();

        // First check if user already existed in db
        if (!$this->isUserExists($email)) {
            // Generating password hash
            $password_hash = PassHash::hash($password);

            // Generating API key
            $api_key = $this->generateApiKey();

            $sqlName = "createUser";
            $param = array($firstname,$lastname,$email,$username,$password_hash,$api_key);
            // insert query
            $stmt = pg_prepare($this->conn,$sqlName,"INSERT INTO auth_user(first_name,last_name, email, username, password, registration_key) values($1,$2,$3,$4,$5,$6)");

            $result = pg_execute($this->conn,$sqlName,$param);

            // Check for successful insertion
            if (!$result) {
                // Failed to create user
                return USER_CREATE_FAILED;
            } else {
                // User successfully inserted
                return USER_CREATED_SUCCESSFULLY;
            }
        } else {
            // User with same email already existed in the db
            return USER_ALREADY_EXISTED;
        }

        return $response;
    }


    //create the activating code
    public function createCode($user_id){
        $response = array();
        $code = $this->generateCode();
        $sqlName = "createCode";
        $sql = "INSERT INTO code(code,auth_user,status) values($1,$2,0)";
        $param = array($code,$user_id);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);

        if (false === $result) {
            return NULL;
        }
        else {
            return $code;
        }

        return $response;
    }

    //activate the app and modify the code status
    public function activateApp($code){
        $response = array();
        $sqlName = "activate";
        $sql = "UPDATE code set status = 1 where code = $1";

        $param = array($code);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);

        return $num_rows > 0;
    }

        //activate the app and modify the code status
    public function activateAppMac($code,$mac){
        $response = array();
        $sqlName = "activate";
        $sql = "UPDATE code set status = 1, mac=$2, mac_status = 1 where code = $1";

        $param = array($code,$mac);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);

        return $num_rows > 0;
    }

            //activate the app and modify the code status
    public function deactivateApp($mac){
        $response = array();
        $sqlName = "deactivateApp";
        $sql = "UPDATE code set mac_status = 0 where mac = $1 and mac_status = 1 ";

        $param = array($mac);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);

        return $num_rows > 0;
    }


    //create the activating code
    public function createSwab($patient_id,$dob,$gender,$seasonal,$prevaccine,$dateofvac,$recorded,$dateofonset,$healthworker,$fever,$measured){
        $response = array();
        date_default_timezone_set('Australia/Victoria');
        $time = date('Y-m-d H:i:s');
        $sqlName = "createSwab";
        $sql = "INSERT INTO t_swab(vaccinated,prev_vaccinated,vaccinated_on,ili_patient,onset_date,healthcare_worker,fever,fever_temp,created_on) values($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING id";
        $param = array($seasonal,$prevaccine,$dateofvac,$recorded,$dateofonset,$healthworker,$fever,$measured,$time);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);
        if($num_rows>0){
            $row=pg_fetch_row($result);
            $swab_id = $row[0];

            $param = array($swab_id,'1',$time);
            $sqlName = "swab_status";
            $sql = "INSERT INTO t_swab_status(t_swab,status,created_on) values($1,$2,$3)";
            $stmt= pg_prepare($this->conn,$sqlName,$sql);
            $result = pg_execute($this->conn,$sqlName,$param);

            $param = array($patient_id,$swab_id,$dob,$gender,$time);
            $sqlName = "createPatient";
            $sql = "INSERT INTO t_swab_patient(id,t_swab,dob,gender,created_on) values($1,$2,$3,$4,$5)";
            $stmt= pg_prepare($this->conn,$sqlName,$sql);
            $result = pg_execute($this->conn,$sqlName,$param);
            $num_rows = pg_affected_rows($result);
            if($num_rows>0){
                return PATIENT_CREATED_SUCCESSFULLY;

            }else{
               return PATIENT_CREATE_FAILED;
            }
        }
        else {
            return SWAB_CREATE_FAILED;
        }

        return $response;
    }


    public function createNewSwabStatus($swab_id,$status){
        $sqlName = "getStatusID";
        $param = array($status);
        $sql = "SELECT id FROM t_status WHERE status ilike $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if ($result) {
            $row=pg_fetch_row($result);
            $statusID = $row[0];
            date_default_timezone_set('Australia/Victoria');
            $time = date('Y-m-d H:i:s');
            $param = array($swab_id, $statusID,$time);
            $sqlName = "swab_status";

            $sql = "UPDATE t_swab_status Set status = $2,modified_on = $3 where t_swab = $1";
            $stmt= pg_prepare($this->conn,$sqlName,$sql);
            $result = pg_execute($this->conn,$sqlName,$param);
            $num_rows = pg_affected_rows($result);
            if($num_rows>0){
                return SWAB_STATUS_CREATED_SUCCESSFULLY;

            }else{
               return SWAB_STATUS_CREATE_FAILED;
            }
        }

    }

    public function createPatientNoFlu($patient_id,$dob,$gender){
        $param = array($patient_id,$dob,$gender);
        $sqlName = "createPatient";
        $sql = "INSERT INTO t_swab_patient(id,dob,gender) values($1,$2,$3)";
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);
        if($num_rows>0){
            return PATIENT_CREATED_SUCCESSFULLY;

        }else{
           return PATIENT_CREATE_FAILED;
        }
    }


    public function createLabResult($t_swab,$t_labresult,$created_on){
        $response = array();
        $sqlName = "createLabResult";
        $sql = "INSERT INTO t_swab_labresults(t_swab,t_labresult,created_on) values($1,$2,$3)";
        $param = array($t_swab,$t_labresult,$created_on);
        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_affected_rows($result);
        if($num_rows>0){
            return SWAB_RESULT_CREATED_SUCCESSFULLY;
        }
        else {
            return SWAB_RESULT_CREATE_FAILED;
        }

        return $response;
    }
    public function updateLabResult($t_swab,$t_labresult,$modified_on){
        $response = array();
        $sqlName = "updateLabResult";
        $sql = "UPDATE t_swab_labresults set (t_labresult,modified_on)=($2,$3) where t_swab = $1 ";
        $param = array($t_swab,$t_labresult,$modified_on);

        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);

        $num_rows = pg_affected_rows($result);
        if($num_rows>0){
            return SWAB_RESULT_UPDATE_SUCCESSFULLY;
        }
        else {
            return SWAB_RESULT_UPDATE_FAILED;
        }

        return $response;
    }


    public function generateID(){
        $response = array();
        $sqlName = "generateID";
        $sql = "SELECT count(*) FROM t_swab_patient";
        $param = array();

        $stmt= pg_prepare($this->conn,$sqlName,$sql);
        $result = pg_execute($this->conn,$sqlName,$param);
        if($result){
            $row = pg_fetch_row($result);
            $response =$row[0]+1;
            return $response;
        }
        return $response;
    }
/*---------------------------GET FUNCTIONS-----------------------------*/
    /**
     * Fetching user by email
     * @param String $email User email id
     */
    public function getUserByEmail($email) {
        $sqlName = "isUserExists";
        $param = array($email);
        $sql = "SELECT id,first_name, last_name, email, registration_key FROM auth_user WHERE email = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if ($result) {
            // $user = $stmt->get_result()->fetch_assoc();
            $row=pg_fetch_row($result);
            $user = array();
            $user["id"] = $row[0];
            $user["firstname"] = $row[1];
            $user["lastname"] = $row[2];
            $user["email"] = $row[3];
            $user["api_key"] = $row[4];
            return $user;
        } else {
            return NULL;
        }
    }

    public function getSwabStatus($swab_id){
        $sqlName = "getSwabStatus";
        $param = array($swab_id);
        $sql = "With raw as(
                SELECT t_swab,tss.status as id, tss.created_on, tss.modified_on
                      FROM t_swab_status tss
                              WHERE tss.t_swab = $1

                )
                select r.id,ts.status,t_swab,r.created_on,r.modified_on from raw r JOIN t_status ts on r.id = ts.id;";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if ($result) {
            $row=pg_fetch_row($result);
            $status = array();
            $status["id"] = $row[0];
            $status["status"] = $row[1];
            $status["swab"] = $row[2];
            $status["created_on"] = $row[3];
            $status["modified_on"] =  $row[4];

            return $status;
        } else {
            return NULL;
        }
    }

    /**
     * Fetching user api key
     * @param String $user_id user id primary key in user table
     */
    public function getApiKeyById($user_id) {
        $sqlName = "getApiKeyById";
        $param = array($user_id);
        // fetching user by email
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT registration_key FROM auth_user WHERE id = $1");
        if (!pg_connection_busy($this->conn)) {
            $result = pg_send_execute($this->conn,$sqlName,$param);

            if ($result) {
                // $api_key = $stmt->get_result()->fetch_assoc();
                // TODO
                $api_key = pg_get_result($this->conn);
                return $api_key;
            } else {
                return NULL;
            }
        }
    }

    /**
     * Fetching user id by activating code
     * @param String $api_key user api key
     */
    public function getUserByCode($code) {
        $sqlName = "getUserByCode";
        $param = array($code);
        $sql = "SELECT c.auth_user,au.registration_key from code c join auth_user au on c.auth_user=au.id WHERE code = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if(!$result){
            return NULL;
        } else {
            $row = pg_fetch_row($result);
            $user = array();
            $user["id"] = $row[0];
            $user["api_key"] = $row[1];
            // User successfully inserted
            return $user;
        }
    }

        /**
     * Fetching user id by activating code
     * @param String $api_key user api key
     */
    public function getUserByMac($mac) {
        $sqlName = "getUserByMac";
        $param = array($mac);
        $sql = "SELECT c.auth_user,au.registration_key from code c join auth_user au on c.auth_user=au.id
                    WHERE c.mac = $1 and c.mac_status = 1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if(!$result){
            return NULL;
        } else {
            $row = pg_fetch_row($result);
            $user = array();
            $user["id"] = $row[0];
            $user["api_key"] = $row[1];
            // User successfully inserted
            return $user;
        }
    }

    /**
     * Fetching user id by api key
     * @param String $api_key user api key
     */
    public function getUserId($api_key) {
        $sqlName = "getUserId";
        $param = array($api_key);
        $sql = "SELECT id from auth_user WHERE registration_key = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        if(!$result){
            return NULL;
        } else {
            $row = pg_fetch_row($result);
            $user_id = $row[0];
            // User successfully inserted
            return $user_id;
        }
    }

    public function getPatientInfo($patient_id){

        $param = array($patient_id);
        $sqlName = "getPatient";
        $sql = "SELECT id,t_swab,gender,dob,created_on from t_swab_patient WHERE id = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_num_rows($result);
        if($num_rows>0){
            $row = pg_fetch_row($result);
            $patient = array();
            $patient["id"] = $row[0];
            $patient["t_swab"] = $row[1];
            $patient["gender"] = $row[2];
            $patient["dob"] = $row[3];
            $patient["created_on"] = $row[4];
            return $patient;

        } else {
           return NULL;
        }

    }

    public function getFluType(){
        $param = array();
        $sqlName = "getFluType";
        $sql = "SELECT id,name,subtype from t_labresult order by id asc";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);
        if(!$result){
            return NULL;
        }else{
            return $result;
        }
    }
    /**
     * Fetching all user tasks
     * @param String $user_id id of the user
     */
    public function getAllUserTasks($user_id) {
        $stmt = $this->conn->prepare("SELECT t.* FROM tasks t, user_tasks ut WHERE t.id = ut.task_id AND ut.user_id = ?");
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $tasks = $stmt->get_result();
        $stmt->close();
        return $tasks;
    }

//-----------------------------CHECK FUNCTIONS--------------------------------


    /**
     * Checking Activating Code
     * @param String $code activating code
     * @return boolean Code status exist/fail
     */
    public function checkCode($code) {
        $sqlName = "checkCode";
        $param = array($code);
        // fetching activating code
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT id FROM code WHERE code = $1 and status = 0");
        $result = pg_execute($this->conn,$sqlName,$param);

        if (pg_num_rows($result) > 0) {
            // Found input code
            return TRUE;
        } else {

            return FALSE;
        }
    }

    /**
     * Checking Activated machine
     * @param String $code activating code
     * @return boolean Code status exist/fail
     */
    public function checkMac($mac) {
        $sqlName = "checkMac";
        $param = array($mac);
        // fetching activating code
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT id FROM code WHERE mac = $1 and mac_status = 1");
        $result = pg_execute($this->conn,$sqlName,$param);

        if (pg_num_rows($result) > 0) {
            // Found input code
            return TRUE;
        } else {

            return FALSE;
        }
    }

    /**
     * Checking for duplicate user by email address
     * @param String $email email to check in db
     * @return boolean
     */
    private function isUserExists($email) {
        $sqlName = "isUserExists";
        $param = array($email);
        $sql = "SELECT id from auth_user WHERE email = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);

        $num_rows = pg_num_rows($result);

        return $num_rows > 0;
    }

    /**
     * Checking user login
     * @param String $email User login email id
     * @param String $password User login password
     * @return boolean User login status success/fail
     */
    public function checkLogin($email, $password) {
        require_once 'PassHash.php';
        $sqlName = "checkLogin";
        $param = array($email);
        // fetching user by email
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT password FROM auth_user WHERE email = $1");
        $result = pg_execute($this->conn,$sqlName,$param);

        if (pg_num_rows($result) > 0) {
            // Found user with the email
            // Now verify the password
            $row = pg_fetch_row($result);
            $password_hash = $row[0];
            if (PassHash::check_password($password_hash, $password)) {
                // User password is correct
                return TRUE;
            } else {
                // user password is incorrect
                return FALSE;
            }
        } else {

            // user not existed with the email
            return FALSE;
        }
    }

        //check whether the swab lab result has been created
    public function checkLabResult($t_swab) {
        $sqlName = "checkLabResult";
        $param = array($t_swab);
        // fetching user by email
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT id FROM t_swab_labresults WHERE t_swab = $1");
        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_num_rows($result);

        return $num_rows > 0;

    }


    public function checkPatient($patient_id){
        $sqlName = "checkPatient";
        $param = array($patient_id);
        $sql = "SELECT id from t_swab_patient WHERE id = $1";

        $stmt = pg_prepare($this->conn,$sqlName,$sql);

        $result = pg_execute($this->conn,$sqlName,$param);
        $num_rows = pg_num_rows($result);
        if($num_rows>0){
            return PATIENT_EXISTED;
        }else{
            return PATIENT_NOT_EXISTED;
        }
    }

    /**
     * Validating user api key
     * If the api key is there in db, it is a valid key
     * @param String $api_key user api key
     * @return boolean
     */
    public function isValidApiKey($api_key) {
        $sqlName = "isValidApiKey";
        $param = array($api_key);
        // fetching user by email
        $stmt = pg_prepare($this->conn,$sqlName,"SELECT id FROM auth_user WHERE registration_key = $1");
        $result = pg_execute($this->conn,$sqlName,$param);

        $num_rows = pg_num_rows($result);

        return $num_rows > 0;
    }


//-----------------------SUPPORT FUNCTIONS-------------------------
    /**
     * Generating random Unique MD5 String for user Api key
     */
    private function generateApiKey() {
        return md5(uniqid(rand(), true));
    }


    /**
     * Generating random activating code
     */
    private function generateCode() {
        $length = 10;
        $char = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        if(!is_int($length) || $length < 0) {
           return false;
        }

        $string = '';
            for($i = $length; $i > 0; $i--) {
            $string .= $char[mt_rand(0, strlen($char) - 1)];
        }

        return $string;
    }


}

?>
