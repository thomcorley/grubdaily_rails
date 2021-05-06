const burgerMenu = document.getElementById("nav-burger");
const navMenu = document.getElementById("nav-menu");

const setMenuHeight = () => {
  if (document.body.clientWidth < 1024) {
    const mainContainerHeight = document.getElementById("main-container").clientHeight;
    navMenu.style.height = `${mainContainerHeight + 50}px`;
  }
};

const handleMenuOnWindowResize = () => {
  if (document.body.clientWidth < 1024) {
    setMenuHeight();
  } else {
    navMenu.style = null;
  }
}

// Use the burger menu to reveal the drop-down nav menu
burgerMenu.addEventListener("click", () => {
  burgerMenu.classList.toggle("is-active");
  navMenu.classList.toggle("is-active");
});

// Set the navMenu height upon page load
document.addEventListener("turbolinks:load", () => {
  setMenuHeight();
});

setMenuHeight();

// Ensure the height of the menu is correct after the window is resized
window.addEventListener("resize", () => {
  handleMenuOnWindowResize();
});
