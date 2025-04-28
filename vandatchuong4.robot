*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${WEBSITE_URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${CORRECT_USERNAME}    Admin
${CORRECT_PASSWORD}    admin123
${WRONG_USERNAME}    BuiVanDat
${WRONG_PASSWORD}    200904

*** Test Cases ***
Quy Trình Đăng Nhập Thành Công
    Khởi Tạo Trình Duyệt
    Truy Cập Trang Đăng Nhập
    Nhập Thông Tin Đăng Nhập    ${CORRECT_USERNAME}    ${CORRECT_PASSWORD}
    Thực Hiện Thao Tác Đăng Nhập
    Xác Minh Đăng Nhập Hoàn Tất
    Tạm Dừng
    Kết Thúc Trình Duyệt

Quy Trình Đăng Nhập Thất Bại
    Khởi Tạo Trình Duyệt
    Truy Cập Trang Đăng Nhập
    Nhập Thông Tin Đăng Nhập    ${WRONG_USERNAME}    ${WRONG_PASSWORD}
    Thực Hiện Thao Tác Đăng Nhập
    Đánh Giá Đăng Nhập Không Thành Công
    Tạm Dừng
    Kết Thúc Trình Duyệt

*** Keywords ***
Khởi Tạo Trình Duyệt
    Open Browser    ${WEBSITE_URL}    chrome
    Maximize Browser Window

Truy Cập Trang Đăng Nhập
    Go To    ${WEBSITE_URL}

Nhập Thông Tin Đăng Nhập
    [Arguments]    ${user}    ${pass}
    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=15s
    Input Text    xpath=//input[@name='username']    ${user}
    Input Text    xpath=//input[@name='password']    ${pass}

Thực Hiện Thao Tác Đăng Nhập
    Click Element    xpath=//button[@type='submit']

Xác Minh Đăng Nhập Hoàn Tất
    Wait Until Page Contains Element    xpath=//h6[text()='Dashboard']    timeout=25s
    Log To Console    [INFO] Đăng nhập vào hệ thống thành công!

Đánh Giá Đăng Nhập Không Thành Công
    Wait Until Element Is Visible    xpath=//div[contains(@class,'oxd-alert-content')]//p    timeout=25s
    Element Text Should Be    xpath=//div[contains(@class,'oxd-alert-content')]//p    Invalid credentials
    Log To Console    [WARNING] Đăng nhập không thành công.

Tạm Dừng
    Sleep    3s

Kết Thúc Trình Duyệt
    Close Browser