let ciudadSelect = document.getElementById("ciudad");
let generoSelect = document.getElementById("genero");
let mesSelect = document.getElementById("mes");
const filtrarCiudad = document.getElementById("filtrarCiudad");
const filtrarGenero = document.getElementById("filtrarGenero");
const filtrarMes = document.getElementById("filtrarMes");
let tableBody = document.getElementById("tbody");
let caption = document.getElementById("caption");
const grafica = document.getElementById("grafica");

filtrarCiudad.addEventListener("click", async () => {
  let filtro = {
    ciudad: ciudadSelect.value,
  };

  let filtro2 = {
    campo: "cliente.ciudad",
    valor: ciudadSelect.value,
  };

  let res = await axios.post("http://localhost:3000/filtrociudad", filtro);
  let data = await res.data;

  let res2 = await axios.post("http://localhost:3000/graficoFiltrado", filtro2);
  let data2 = await res2.data;

  crearTabla(data);
  crearGrafico(data2);
});

filtrarGenero.addEventListener("click", async () => {
  let filtro = {
    genero: generoSelect.value,
  };

  let filtro2 = {
    campo: "cliente.genero",
    valor: generoSelect.value,
  };

  let res = await axios.post("http://localhost:3000/filtrogenero", filtro);
  let data = await res.data;

  let res2 = await axios.post("http://localhost:3000/graficoFiltrado", filtro2);
  let data2 = await res2.data;

  crearTabla(data);

  crearGrafico(data2);
});

filtrarMes.addEventListener("click", async () => {
  let filtro = {
    mes: mesSelect.value,
  };

  let filtro2 = {
    campo: "tiempo.mes",
    valor: mesSelect.value,
  };

  let res = await axios.post("http://localhost:3000/filtromes", filtro);
  let data = await res.data;

  let res2 = await axios.post("http://localhost:3000/graficoFiltrado", filtro2);
  let data2 = await res2.data;

  crearTabla(data);

  crearGrafico(data2);
});

let enlistar = async () => {
  let res = await axios.get("http://localhost:3000/ciudad");
  let data = res.data;

  for (const item of data) {
    let opcion = document.createElement("option");
    opcion.value = item.ciudad;
    opcion.text = item.ciudad;
    ciudadSelect.add(opcion);
  }

  let res2 = await axios.get("http://localhost:3000/genero");
  let data2 = res2.data;

  for (const item of data2) {
    switch (item.genero) {
      case "Female":
        item.text = "Femenino";
        break;
      case "Bigender":
        item.text = "Bigenero";
        break;
      case "Agender":
        item.text = "Agénero";
        break;
      case "Genderfluid":
        item.text = "Género Fluido";
        break;
      case "Male":
        item.text = "Masculino";
        break;

      default:
        break;
    }

    let opcion = document.createElement("option");
    opcion.value = item.genero;
    opcion.text = item.text;
    generoSelect.add(opcion);
  }

  let res3 = await axios.get("http://localhost:3000/mes");
  let data3 = res3.data;

  for (const item of data3) {
    switch (item.mes) {
      case "1":
        item.text = "Enero";
        break;
      case "2":
        item.text = "Febrero";
        break;
      case "3":
        item.text = "Marzo";
        break;
      case "4":
        item.text = "Abril";
        break;
      case "5":
        item.text = "Mayo";
        break;
      case "6":
        item.text = "Junio";
        break;
      case "7":
        item.text = "Julio";
        break;
      case "8":
        item.text = "Agosto";
        break;
      case "9":
        item.text = "Septiembre";
        break;
      case "10":
        item.text = "Octubre";
        break;
      case "11":
        item.text = "Noviembre";
        break;
      case "12":
        item.text = "Diciembre";
        break;

      default:
        break;
    }
    let opcion = document.createElement("option");
    opcion.value = item.mes;
    opcion.text = item.text;
    mesSelect.add(opcion);
  }
};

const crearTabla = (data) => {
  caption.textContent = `${Object.keys(data).length} Registros`;

  tableBody.innerHTML = ``;
  for (const item of data) {
    let ciudad = `<td>${item.ciudad}</td>`;
    let genero = `<td>${item.genero}</td>`;
    let periodo = `<td>${item.periodo}</td>`;
    let valor = `<td>${item.valor}</td>`;
    tableBody.innerHTML += `<tr>${ciudad + genero + periodo + valor}</tr>`;
  }
};

const crearGrafico = async (data) => {
  let labels = [];
  let dataset = [];

  for (const item of data) {
    switch (item.mes) {
      case "1":
        item.text = "Enero";
        break;
      case "2":
        item.text = "Febrero";
        break;
      case "3":
        item.text = "Marzo";
        break;
      case "4":
        item.text = "Abril";
        break;
      case "5":
        item.text = "Mayo";
        break;
      case "6":
        item.text = "Junio";
        break;
      case "7":
        item.text = "Julio";
        break;
      case "8":
        item.text = "Agosto";
        break;
      case "9":
        item.text = "Septiembre";
        break;
      case "10":
        item.text = "Octubre";
        break;
      case "11":
        item.text = "Noviembre";
        break;
      case "12":
        item.text = "Diciembre";
        break;

      default:
        break;
    }

    labels.push(item.text);
    dataset.push(item.valor);
  }

  const configuration = {
    label: "Ventas por mes",
    data: dataset,
    backgroundColor: "rgba(128, 0, 128, 0.2)", // Color de fondo
    borderColor: "rgba(128, 0, 128, 1)", // Color del borde
    borderWidth: 1, // Ancho del borde
  };

  var tipo = labels.length === 1 ? "bar" : "line";

  new Chart(grafica, {
    type: tipo, // Tipo de gráfica
    data: {
      labels: labels,
      datasets: [
        configuration,
        // Aquí más datos...
      ],
    },
    options: {
      scales: {
        yAxes: [
          {
            ticks: {
              beginAtZero: true,
            },
          },
        ],
      },
    },
  });
};

const tablaCompleta = async () => {
  let res = await axios.get("http://localhost:3000/data");
  let data = await res.data;

  let res2 = await axios.get("http://localhost:3000/graficoPrincipal");
  let data2 = await res2.data;

  crearTabla(data);
  crearGrafico(data2);
};

enlistar();

tablaCompleta();
