<?php

require_once '../include/DbHandler.php';
require_once '../include/PassHash.php';
require '.././libs/Slim/Slim.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

// User id from db - Global Variable
$user_id = NULL;

/**
 * Adding Middle Layer to authenticate every request
 * Checking if the request has valid api key in the 'Authorization' header
 */
function authenticate(\Slim\Route $route) {
    // Getting request headers
    $headers = apache_request_headers();
    $response = array();
    $app = \Slim\Slim::getInstance();

    // Verifying Authorization Header
    if (isset($headers['Authorization'])) {
        $db = new DbHandler();

        // get the api key
        $api_key = $headers['Authorization'];
        // validating api key
        if (!$db->isValidApiKey($api_key)) {
            // api key is not present in users table
            $response["error"] = true;
            $response["message"] = "Access Denied. Invalid Api key";
            echoRespnse(401, $response);
            $app->stop();
        } else {
            global $user_id;
            // get user primary key id
            $user_id = $db->getUserId($api_key);
        }
    } else {
        // api key is missing in header
        $response["error"] = true;
        $response["message"] = "Api key is misssing";
        echoRespnse(400, $response);
        $app->stop();
    }
}

/**
 * ----------- METHODS WITHOUT AUTHENTICATION ---------------------------------
 */
/**
 * User Registration
 * url - /register
 * method - POST
 * params - name, email, password
 */
$app->post('/register', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('firstname','lastname','username', 'email', 'password'));

            $response = array();

            // reading post params
            $firstname = $app->request->post('firstname');
            $lastname = $app->request->post('lastname');
            $username = $app->request->post('username');
            $email = $app->request->post('email');
            $password = $app->request->post('password');

            // validating email address
            validateEmail($email);

            $db = new DbHandler();
            $res = $db->createUser($firstname,$lastname, $email,$username, $password);

            if ($res == USER_CREATED_SUCCESSFULLY) {
                $response["error"] = false;
                $response["message"] = "You are successfully registered";
            } else if ($res == USER_CREATE_FAILED) {
                $response["error"] = true;
                $response["message"] = "Oops! An error occurred while registereing";
            } else if ($res == USER_ALREADY_EXISTED) {
                $response["error"] = true;
                $response["message"] = "Sorry, this email already existed";
            }
            // echo json response
            echoRespnse(201, $response);
        });
/**
 * App activate
 * url - /activate
 * method - POST
 */
$app->post('/activate', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('code'));

            // reading post params
            $code = $app->request()->post('code');

            $response = array();

            $db = new DbHandler();
            // check for correct code
            if ($db->checkCode($code)) {
                // get the user by id
                $user = $db->getUserByCode($code);

                if ($user != NULL) {
                    $db->activateApp($code);
                    $response["error"] = false;
                    $response['id'] = $user['id'];
                    $response['apiKey'] = $user['api_key'];
                } else {
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }
            } else {
                // user credentials are wrong
                $response['error'] = true;
                $response['message'] = 'Activation failed. Incorrect credentials';
            }

            echoRespnse(200, $response);
        });

/**
 * App activate
 * url - /activateMac
 * method - POST
 * params - code ,mac
 */
$app->post('/activateMac', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('code','mac'));

            // reading post params
            $code = $app->request()->post('code');
            $mac = $app->request()->post('mac');

            $response = array();

            $db = new DbHandler();
            // check for correct code
            if ($db->checkCode($code)) {
                $db->deactivateApp($mac);

                if($db->activateAppMac($code,$mac)){
                    $response["error"] = false;
                    $response['message'] = 'Activation Successful';
                }else{
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }

            } else {
                // user credentials are wrong
                $response['error'] = true;
                $response['message'] = 'Activation failed. Incorrect credentials';
            }

            echoRespnse(200, $response);
        });

/**
 * App deactivate
 * url - /deactivate
 * method - POST
 * params - mac
 */
$app->post('/deactivate', 'authenticate', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('mac'));

            // reading post params
            $mac = $app->request()->post('mac');


            $response = array();

            $db = new DbHandler();
            // check for correct code
            if ($db->checkMac($mac)) {
                // get the user by id
                if($db->deactivateApp($mac)){
                    $response["error"] = false;
                    $response['message'] = 'Deactivate Successful';
                }else{
                    $response["error"] = true;
                    $response['message'] = 'Deactivate Failed';
                }

            } else {
                // user credentials are wrong
                $response['error'] = true;
                $response['message'] = 'Invalid Machine';
            }

            echoRespnse(200, $response);
        });

$app->post('/getUser', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('mac'));

            // reading post params
            $mac = $app->request()->post('mac');

            $response = array();

            $db = new DbHandler();
            // check for correct code
            if ($db->checkMac($mac)) {
                // get the user by mac
                $user = $db->getUserByMac($mac);

                if ($user != NULL) {
                    $response["error"] = false;
                    $response['id'] = $user['id'];
                    $response['apiKey'] = $user['api_key'];
                } else {
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please restart the app again";
                }
                echoRespnse(200, $response);
            } else {
                // user credentials are wrong
                $response['error'] = true;
                $response['message'] = 'This machine is not activated';
                echoRespnse(401, $response);
            }
        });

/**
 * User Login
 * url - /login
 * method - POST
 * params - email, password
 */
$app->post('/login', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('email', 'password'));

            // reading post params
            $email = $app->request()->post('email');
            $password = $app->request()->post('password');
            $response = array();

            $db = new DbHandler();
            // check for correct email and password
            if ($db->checkLogin($email, $password)) {
                // get the user by email
                $user = $db->getUserByEmail($email);

                if ($user != NULL) {
                    $response["error"] = false;
                    $response['id'] = $user['id'];
                    $response['email'] = $user['email'];
                    $response['apiKey'] = $user['api_key'];
                    $response['firstname'] = $user['firstname'];
                    $response['lastname'] = $user['lastname'];
                } else {
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }
            } else {
                // user credentials are wrong
                $response['error'] = true;
                $response['message'] = 'Login failed. Incorrect credentials';
            }

            echoRespnse(200, $response);
        });

/*
 * ------------------------ METHODS WITH AUTHENTICATION ------------------------
 */

/**
 * Creating new task in db
 * method POST
 * params - name
 * url - /tasks/
 */
$app->post('/code', 'authenticate', function() use ($app) {
            // check for required params

            $response = array();

            global $user_id;
            $db = new DbHandler();

            // creating new task
            $code = $db->createCode($user_id);

            if ($code != NULL) {
                $response["error"] = false;
                $response["message"] = "Code created successfully";
                $response["code"] = $code;
                echoRespnse(201, $response);
            } else {
                $response["error"] = true;
                $response["message"] = "Failed to create code. Please try again";
                echoRespnse(200, $response);
            }
        });
/**
 * Creating new swap in db
 * method POST
 * url - /swab/
 */
$app->post('/swab', 'authenticate', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('patient_id','dob','gender','seasonal','prevaccine','dateofvac','recorded','dateofonset','healthworker','fever','measured'));

            $response = array();
            $patient_id = $app->request->post('patient_id');
            $dob = $app->request->post('dob');
            $gender = $app->request->post('gender');
            $seasonal = $app->request->post('seasonal');
            $prevaccine = $app->request->post('prevaccine');
            $dateofvac = $app->request->post('dateofvac');
            $recorded = $app->request->post('recorded');
            $dateofonset = $app->request->post('dateofonset');
            $healthworker = $app->request->post('healthworker');
            $fever = $app->request->post('fever');
            $measured = $app->request->post('measured');

            $db = new DbHandler();
            // creating new task
            $swab = $db->createSwab($patient_id,$dob,$gender,$seasonal,$prevaccine,$dateofvac,$recorded,$dateofonset,$healthworker,$fever,$measured);

            if ($swab == PATIENT_CREATED_SUCCESSFULLY) {
                $response["error"] = false;
                $response["message"] = "Swab and patient created successfully";
                echoRespnse(201, $response);
            } else {
                $response["error"] = true;
                $response["message"] = "Failed to create swab. Please try again";
                echoRespnse(200, $response);
            }
        });

/**
 * Creating new swap in db
 * method POST
 * url - /swab/
 */
$app->post('/swabNoFever', 'authenticate', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('patient_id','dob','gender','seasonal','prevaccine','dateofvac','recorded','dateofonset','healthworker','fever'));

            $response = array();
            $patient_id = $app->request->post('patient_id');
            $dob = $app->request->post('dob');
            $gender = $app->request->post('gender');
            $seasonal = $app->request->post('seasonal');
            $prevaccine = $app->request->post('prevaccine');
            $dateofvac = $app->request->post('dateofvac');
            $recorded = $app->request->post('recorded');
            $dateofonset = $app->request->post('dateofonset');
            $healthworker = $app->request->post('healthworker');
            $fever = $app->request->post('fever');
            $measured = null;

            $db = new DbHandler();
            // creating new task
            $swab = $db->createSwab($patient_id,$dob,$gender,$seasonal,$prevaccine,$dateofvac,$recorded,$dateofonset,$healthworker,$fever,$measured);

            if ($swab == PATIENT_CREATED_SUCCESSFULLY) {
                $response["error"] = false;
                $response["message"] = "Swab and patient created successfully";
                echoRespnse(201, $response);
            } else {
                $response["error"] = true;
                $response["message"] = "Failed to create swab. Please try again";
                echoRespnse(200, $response);
            }
        });

$app->post('/patientNoFlu', 'authenticate', function() use ($app) {
            // check for required params
            verifyRequiredParams(array('patient_id','dob','gender'));

            $response = array();
            $patient_id = $app->request->post('patient_id');
            $dob = $app->request->post('dob');
            $gender = $app->request->post('gender');

            $db = new DbHandler();
            // creating new task
            $swab = $db->createPatientNoFlu($patient_id,$dob,$gender);

            if ($swab == PATIENT_CREATED_SUCCESSFULLY) {
                $response["error"] = false;
                $response["message"] = "patient created successfully";
                echoRespnse(201, $response);
            } else {
                $response["error"] = true;
                $response["message"] = "Failed to create patient. Please try again";
                echoRespnse(200, $response);
            }
        });

$app->post('/swabPatient','authenticate',function() use($app){
            verifyRequiredParams(array('patient_id'));
            $response = array();

            $patient_id = $app->request()->post('patient_id');

            $db= new DbHandler();
            $check = $db->checkPatient($patient_id);
            if($check == PATIENT_NOT_EXISTED){
                $response['error'] = true;
                $response['message'] = "invaild QR code";
            }else if($check == PATIENT_EXISTED){
                $patient = $db->getPatientInfo($patient_id);
                if($patient!=NULL){
                    $response["error"] = false;
                    $response['id'] = $patient['id'];
                    $response['t_swab'] = $patient['t_swab'];
                    $response['gender'] = $patient['gender'];
                    $response['dob'] = $patient['dob'];
                    $response['created_on'] = $patient['created_on'];
                }else {
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }
            }
            echoRespnse(200, $response);

});

$app->post('/swabResult','authenticate',function() use($app){
            verifyRequiredParams(array('t_swab','t_labresult'));
            $response = array();

            $t_swab = $app->request()->post('t_swab');
            $t_labresult=$app -> request()->post('t_labresult');
            $time = $app->request()->post('time');

            $db= new DbHandler();

            if($db->checkLabResult($t_swab)){
                $result = $db->updateLabResult($t_swab,$t_labresult,$time);
                if ($result==SWAB_RESULT_UPDATE_SUCCESSFULLY) {
                    $response["error"] = false;
                    $response['message'] = "The Swab Lab Result update successfully";
                }
                elseif($result ==SWAB_RESULT_UPDATE_FAILED ){
                    $response['error'] = true;
                    $response['message'] = "An error occurred while update swab result";
                }else{
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }
            }else{

                $result = $db->createLabResult($t_swab,$t_labresult,$time);
                if($result==SWAB_RESULT_CREATED_SUCCESSFULLY){
                    $response["error"] = false;
                    $response['message'] = "The Swab Lab Result created successfully";
                }elseif ($result == SWAB_RESULT_CREATE_FAILED) {
                    $response['error'] = true;
                    $response['message'] = "An error occurred while creating swab result";
                }else {
                    // unknown error occurred
                    $response['error'] = true;
                    $response['message'] = "An error occurred. Please try again";
                }
            }
            echoRespnse(200, $response);

});

$app->post('/currentSwabStatus','authenticate',function() use($app){
            verifyRequiredParams(array('t_swab'));
            $response = array();

            $t_swab = $app->request()->post('t_swab');

            $db= new DbHandler();
            $result = $db->getSwabStatus($t_swab);
            if($result !=NULL){
                $response["error"] = false;
                $response["id"] = $result["id"];
                $response["status"] = $result["status"];
                $response["t_swab"] = $result["swab"];
                $response["created_on"] = $result["created_on"];
                $response["modified_on"] = $result["modified_on"];
            }else{
                $response["error"] = true;
                $response["message"] = "The swab information is not existed";
            }

            echoRespnse(200, $response);

});

$app->post('/updateSwabStatus','authenticate',function() use($app){
            verifyRequiredParams(array('t_swab','status'));
            $response = array();

            $t_swab = $app->request()->post('t_swab');
            $status = $app->request()->post('status');

            $db= new DbHandler();
            $result = $db->createNewSwabStatus($t_swab,$status);
            if($result == SWAB_STATUS_CREATED_SUCCESSFULLY){
                $response["error"] = false;
                $response['message'] = "The Swab Status updated successfully";

            }else if($result == SWAB_STATUS_CREATE_FAILED){
                $response["error"] = true;
                $response["message"] = "The new swab status created is failed";
            }else{
                $response['error'] = true;
                $response['message'] = "An error occurred. Please try again";
            }
            echoRespnse(200, $response);

});

//--------------------------------GET ------------------------
/**
 * Listing all types of flu
 * method GET
 * url /tasks
 */
$app->GET('/fluType', 'authenticate', function() {
            $response = array();
            $db = new DbHandler();

            // fetching all user tasks
            $result = $db->getFluType();

            $response["error"] = false;
            $response["result"] = array();

            // looping through result and preparing tasks array
            while ($row = pg_fetch_row($result)) {
                $tmp = array();
                $tmp["id"] = $row[0];
                $tmp["name"] = $row[1];
                $tmp["subtype"] = $row[2];
                array_push($response["result"], $tmp);
            }
            echoRespnse(200, $response);
        });

$app->GET('/newID', 'authenticate', function() {
            $response = array();
            $db = new DbHandler();

            // fetching all user tasks
            $result = $db->generateID();

            // looping through result and preparing tasks array
            if ($result != NULL) {
                $response["error"] = false;
                $response["id"] = $result;
                echoRespnse(201, $response);
            } else {
                $response["error"] = true;
                $response["message"] = "Error occurred. ";
                echoRespnse(200, $response);
            }
        });
//------------------------SUPPORT FUNTIONS------------------------------------

/**
 * Verifying required params posted or not
 */
function verifyRequiredParams($required_fields) {
    $error = false;
    $error_fields = "";
    $request_params = array();
    $request_params = $_REQUEST;
    // Handling PUT request params
    if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
        $app = \Slim\Slim::getInstance();
        parse_str($app->request()->getBody(), $request_params);
    }
    foreach ($required_fields as $field) {
        if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
            $error = true;
            $error_fields .= $field . ', ';
        }
    }

    if ($error) {
        // Required field(s) are missing or empty
        // echo error json and stop the app
        $response = array();
        $app = \Slim\Slim::getInstance();
        $response["error"] = true;
        $response["message"] = 'Required field(s) ' . substr($error_fields, 0, -2) . ' is missing or empty';
        echoRespnse(400, $response);
        $app->stop();
    }
}

/**
 * Validating email address
 */
function validateEmail($email) {
    $app = \Slim\Slim::getInstance();
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $response["error"] = true;
        $response["message"] = 'Email address is not valid';
        echoRespnse(400, $response);
        $app->stop();
    }
}

/**
 * Echoing json response to client
 * @param String $status_code Http response code
 * @param Int $response Json response
 */
function echoRespnse($status_code, $response) {
    $app = \Slim\Slim::getInstance();
    // Http response code
    $app->status($status_code);

    // setting response content type to json
    $app->contentType('application/json');

    echo json_encode($response);
}

$app->run();
?>