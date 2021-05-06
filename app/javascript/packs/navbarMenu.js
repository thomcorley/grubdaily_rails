const burgerMenu = document.getElementById("nav-burger");
const navMenu = document.getElementById("nav-menu");

const setMenuHeight = () => {
  if (window.screen.width < 1024) {
    const mainContainerHeight = document.getElementById("main-container").clientHeight;
    navMenu.style.height = `${mainContainerHeight + 50}px`;
  }
};

// Use the burger menu to reveal the drop-down nav menu
burgerMenu.addEventListener("click", () => {
  burgerMenu.classList.toggle("is-active");
  navMenu.classList.toggle("is-active");
});

// Set the navMenu height upon page load
document.addEventListener("turbolinks:load", () => {
  setMenuHeight();
});

// Ensure the height of the menu is correct after the window is resized
window.addEventListener("resize", () => {
  if (window.screen.width < 1024) {
    setMenuHeight();
  } else {
    navMenu.style = null;
  }
});


setMenuHeight();
