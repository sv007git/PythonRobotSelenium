*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}         https://reqres.in
${page_id}          2
${expectedname}     test
${expectedjob}      team leader
${updated_expectedname}     update_test
${updated_expectedjob}      resident
${bearerToken}      Bearer afafsagsgfjfj
*** Test Cases ***

Get Request Test
    Create Session  mysession  ${base_url}  verify=true

#    ${headers}  Create Dictionary       Authorization=${bearerToken}    Content-Type=application/json
#    ${response}=  GET On Session  mysession  /api/users     params=page=${page_id}      headers=${headers}

    ${response}=  GET On Session  mysession  /api/users     params=page=${page_id}
    Status Should Be  200  ${response}

    Should Be Equal As Strings    michael.lawson@reqres.in  ${response.json()}[data][0][email]
    log to console      ${response.json()}

POST Request Test
    Create Session  mysession  ${base_url}  verify=true
    ${req_body}=  Create Dictionary    name=test        job=team leader
    ${response}=     POST On Session  mysession  /api/users     json=${req_body}    expected_status=201
    log      ${response.json()}

    #Check the value of the header Content-Type
    ${getHeaderValue}=  Get From Dictionary  ${response.headers}  Content-Type
    Should be equal  ${getHeaderValue}  application/json; charset=utf-8

    #Validation type 1
    ${body}=  Convert To String  ${response.content}
    Should Contain  ${body}  ${expectedname}
    Should Contain  ${body}  ${expectedjob}

    #Validation type 2
    Dictionary Should Contain Key     ${response.json()}     id
    ${name}=    Get From Dictionary     ${response.json()}    name
    Should Be Equal As Strings    ${expectedname}   ${name}

    ${job}=    Get From Dictionary     ${response.json()}    job
    Should Be Equal As Strings    ${expectedjob}    ${job}


PUT Request Test
    Create Session  mysession  ${base_url}  verify=true
    ${req_body}=  Create Dictionary    name=update_test        job=resident
    ${response}=     PUT On Session       mysession  /api/users+/2     json=${req_body}    expected_status=200
    log      ${response.json()}

    #Validation type 2
    Dictionary Should Contain Key     ${response.json()}     name
    ${name}=    Get From Dictionary     ${response.json()}    name
    Should Be Equal As Strings    ${updated_expectedname}    ${name}

    Dictionary Should Contain Key     ${response.json()}     job
    ${job}=    Get From Dictionary     ${response.json()}    job
    Should Be Equal As Strings    ${updated_expectedjob}    ${job}


DELETE Request Test
    Create Session  mysession  ${base_url}  verify=true
    ${delete_resp}=   DELETE On Session    mysession  /api/users+/2           expected_status=204

