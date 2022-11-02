

const res = await fetch('https://dog.ceo/api/breeds/list/all');
const json = await res.json();
console.log(json);

