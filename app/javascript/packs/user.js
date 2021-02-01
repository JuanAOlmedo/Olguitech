const password = document.querySelector('#user_password'),
      passwordConfirmation = document.querySelector('#user_password_confirmation');

passwordConfirmation.addEventListener('input', checkPassword);
password.addEventListener('input', checkPasswordLength);

function checkPassword() {
    if (password.value != passwordConfirmation.value) {
        passwordConfirmation.classList.add('wrong')
        passwordConfirmation.classList.remove('right')
    } else {
        passwordConfirmation.classList.add('right')
        passwordConfirmation.classList.remove('wrong')
    }
}

function checkPasswordLength() {
    if (password.value.length <= 7) {
        password.classList.add('wrong')
        passwordConfirmation.classList.remove('right')
    } else {
        password.classList.add('right')
        password.classList.remove('wrong')
    }
}