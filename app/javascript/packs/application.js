// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@popperjs/core")

import "bootstrap"
import('stylesheets/application.scss');

// Import the specific modules you may need (Modal, Alert, etc)
import { Tooltip, Popover } from "bootstrap"

// The stylesheet location we created earlier
require("../stylesheets/application.scss")

// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
document.addEventListener("turbolinks:load", () => {
    // Both of these are from the Bootstrap 5 docs
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl)
    })

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
        return new Popover(popoverTriggerEl)
    })
})

import Rails from "@rails/ujs"
require("jquery")
Rails.start()

window.addEventListener("load", () => {
  const active_links = document.querySelectorAll("tr a.toggle[data-remote]");
  active_links.forEach((element) => {
    element.addEventListener("ajax:success", (event) => {
      element.innerHTML = element.innerHTML == "Active" ? "Disactive" : "Active"
    });
  });
});

window.onload = function() {
  const pages_auth = ['sign_in', 'sign_out']
  let curr_page = window.location.pathname.split("/").pop()
  let admin_page = window.location.pathname.split("/")[1]

  if ( pages_auth.includes(curr_page) == true){
    check_email_input()
  }
  if ( admin_page == 'admin'){
    hide_bredcrumbs_panel();
  }
  if (curr_page == 'new'){
    new_user()
  };
  if (curr_page == 'edit'){
    edit_user()
  };
};

//
function new_user(){
const element = document.getElementById("new-user");
  element.addEventListener("ajax:success", function (data){
    query()
  });
};

function edit_user(){
  const element = document.getElementById("edit-user");
  element.addEventListener("ajax:success", function (data){
   query_edit()
  });
};
//
function query(){
Rails.ajax({
  type: "GET",
  dataType: "json", 
  url: "new?generate=true",
  success: function(repsonse){
    //console.log(repsonse)
    const data = (repsonse["new_user"]["name"])
    insert_data_to_form(data);
  },
 // error: function(repsonse){...}
});
}

function query_edit(){
  Rails.ajax({
    type: "GET",
    dataType: "json", 
    url: "edit?edit=true",
    success: function(repsonse){
      enabled_form_elements();
    },
   // error: function(repsonse){...}
  });
  }

  function enabled_form_elements(){
    let inputs = document.querySelectorAll('input')
    inputs.forEach((input) => {
      input.disabled = false; 
    });
    let check_box = document.getElementById('check-box-active')
    check_box.disabled = false;
    let submits = document.querySelectorAll('input[type=submit]')
    submits.forEach((submit) => {
      submit.disabled = false; 
    });
    let select = document.getElementById('role-select');
    select.disabled = false;
    // let div_link = document.getElementById('cancel-link');
    // const link = document.createElement("a");
    // const linkText = document.createTextNode("Cancel");
    // link.appendChild(linkText);
    // link.title = "Cancel";
    // link.href = "edit_admin_user_path(@admin_user)";
    // div_link.appendChild(link);
  }

//
function insert_data_to_form(name){
  document.getElementById("name").value = name;
  document.getElementById("email").value = name;
  document.getElementById("password").value = name;
  document.getElementById("confirm_password").value = name;
}

// document.addEventListener('DOMContentLoaded', (event) => {
//   check_email_input();
// });

// Валидация электронной почты
function ValidateEmail(mail) 
{
  var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  if(mail.match(mailformat)) { return (true) };
  return (false);
}
// Проверка в поле введенного адресса эл.почты 
function check_email_input()
{
  let input = document.getElementById('input_email');
  let warning_label = document.getElementById('label_wrong_email');
  input.addEventListener('input', () => { 
    if (input.value == '') { warning_label.innerHTML = ' '; toggle_submit('off'); return; }
    if (ValidateEmail(input.value) == false) { 
      warning_label.innerHTML = 'Wrong_email!';
      toggle_submit('off'); 
    }
      else{ warning_label.innerHTML = ' '; 
      toggle_submit('on'); 
    }
  });
}
// Включение отключение кнопки подтверждения
function toggle_submit(val){
  let button_submit = document.getElementById("submit_log_in");
  if (val == 'on') {
    button_submit.disabled = false
  } else { button_submit.disabled = true }
}

//
function hide_bredcrumbs_panel(){
  let close_button = document.getElementById('close_breadcrumbs_bar')
  let bredcrumbs_div = document.getElementById('breadcrumbs')
  close_button.onclick = function(event){
    if (bredcrumbs_div){
      bredcrumbs_div.style.visibility = "hidden"
    }
  }
}

//
function generate_email(){
  let generate_link = document.getElementById('generate_user')
  generate_link.onclick = function(event){
    
    
  }

}