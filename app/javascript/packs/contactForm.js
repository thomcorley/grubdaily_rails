const errorFieldsArray = Array.from(document.getElementsByClassName("field_with_errors"));
const formFieldElements = document.getElementsByClassName("form-field");
const subscribeElement = document.getElementById("subscribe-checkbox");
const emailErrorDiv = document.querySelector(".email-error.form-error-message")
const emailField = document.querySelector(".input.form-field.email")
const formParentElement = document.getElementById("contact-form");

const formFieldValueIsBlank = (formField) => (
  formField.value == "" || formField.value == null
)

// Only proceed if there are any divs with the class `field_with_errors`,
// which is the error div created by Rails upon redirect with the model errors
if (errorFieldsArray.length > 0) {
  let blankFields = 0;

  // Remove the Rails error class so we can apply our own styles
  errorFieldsArray.forEach(errorField => {
    errorField.classList.remove("field_with_errors");
  });

  // Add the `is-danger` Bulma class to all blank form fields
  Array.prototype.forEach.call(formFieldElements, formField => {
    if (formFieldValueIsBlank(formField)) {
      blankFields += 1;
      formField.classList.add("is-danger");
    }
  });

  // Add the `is-danger` Bulma class to the email field if the email is invalid
  if ( emailErrorDiv != null ) {
    emailField.classList.add("is-danger");
    // Remove the invalid message if the field is empty
    if (formFieldValueIsBlank(emailField)) {
      emailErrorDiv.remove();
    }
  }

  if (blankFields > 0) {
    const notice = document.createElement("div");
    notice.classList.add("block");
    notice.classList.add("form-error-message");
    notice.innerHTML = "Please complete all fields";

    formParentElement.insertBefore(notice, subscribeElement);
  };
}
