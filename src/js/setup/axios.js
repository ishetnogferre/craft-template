import axios from 'axios';
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

const tokenName = document.head.querySelector('meta[name="csrf-token-name"]');
const token = document.head.querySelector('meta[name="csrf-token"]');
if (token && tokenName) {
    axios.defaults.headers.common[tokenName.content] = token.content;
} else {
    // eslint-disable-next-line no-console
    console.error(
        "CSRF token not found: https://laravel.com/docs/csrf#csrf-x-csrf-token"
    );
}
window.axios = axios;
