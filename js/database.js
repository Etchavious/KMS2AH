//Build Tabulator
var table = new Tabulator("#example-table", {
    height:"311px",
    layout:"fitColumns",
    ajaxURL:"/data/itemdatabase.json",
    ajaxProgressiveLoad:"scroll",
    paginationSize:20,
    placeholder:"No Data Set",
    columns:[
        {title:"ID", field:"ID", sorter:"string"},
        {title:"Name - Korean", field:"NAME_KR", sorter:"string"},
        {title:"Name - English", field:"NAME_EN", sorter:"string"},
    ],
});