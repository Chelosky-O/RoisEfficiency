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
document.getElementById("cover-ctn-search").addEventListener("click", ocultar_buscador);


//Variables a utilizar
bars_search = document.getElementById("ctn-bars-search");
cover_ctn_search = document.getElementById("cover-ctn-search");
inputSearch = document.getElementById("inputSearch");
box_search =document.getElementById("box-search");


//Funcion mostrar el buscador
function mostrar_buscador(){
    bars_search.style.top = "80px"
    cover_ctn_search.style.display = "block";
    inputSearch.focus();

    if(inputSearch.value === ""){
        box_search.style.display = "none";
    }
}



//funcion para ocultar buscado
function ocultar_buscador(){
    bars_search.style.top = "-10px";
    cover_ctn_search.style.display = "none";
    inputSearch.value = "";
    box_search.style.display = "none";

}

//Creando filtrado de busqueda

document.getElementById("inputSearch").addEventListener("keyup", buscador_interno);

function buscador_interno(){
    filter = inputSearch.value.toUpperCase();
    li = box_search.getElementsByTagName("li");

    //Recorriendo elementos a filtrar mediantes los li
    for(i = 0; i < li.length; i++){
        a = li[i].getElementsByTagName("a")[0];
        textValue = a.textContent || a.innerText;

        if(textValue.toUpperCase().indexOf(filter) > -1){
            li[i].style.display = "";
            box_search.style.display = "block";

            if(inputSearch.value === ""){
                box_search.style.display = "none";
            }

        }else{
            li[i].style.display = "none";
        }
    }
}


function setupSearchResults() {
    const searchResults = document.querySelectorAll('#box-search a');
  
    searchResults.forEach(result => {
      result.addEventListener('click', function(event) {
        event.preventDefault();
  
        const productId = this.getAttribute('data-product-id');
  
        fetch('/view_product', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              id: productId
            })
          })
          .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
          })
          .then(data => {
            // Aquí puedes manejar la respuesta del servidor.
            // Por ejemplo, podrías redirigir al usuario a la página del producto.
            window.location.href = 'pages/producto/' + productId; // Actualiza esta URL con la URL correcta.
          });
        
      });
    });
  }
  