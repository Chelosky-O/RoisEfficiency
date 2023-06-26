/*!
* Start Bootstrap - Shop Item v5.0.6 (https://startbootstrap.com/template/shop-item)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-shop-item/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project

//BUscador
//ejecutandose
document.getElementById("icon-search").addEventListener("click", mostrar_buscador);


//Variables a utilizar
bars_search = document.getElementById("ctn-bars-search");
cover_ctn_search = document.getElementById("cover-ctn-search");
inputSearch = document.getElementById("inputSearch");
box_search =document.getElementById("box-search");


//Funcion mostrar el buscador
function mostrar_buscador(){
    bars_search.style.top = "80px"
}