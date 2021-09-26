//Build Tabulator
var table = new Tabulator("#example-table", {
    ajaxConfig:{
		method: "GET",
		mode: "cors"
	},
	ajaxURL:"https://etchavious.github.io/KMS2AH/data/itemdatabase.json",
	layout:"fitData",
    placeholder:"No Data Set",
    columns:[
        {title:"ID", field:"ID", sorter:"string"},
        {title:"Name - Korean", field:"Name_KR"},
        {title:"Name - English", field:"Name_EN"},
    ],
	ajaxResponse:function(url, params, response){
        //url - the URL of the request
        //params - the parameters passed with the request
        //response - the JSON object returned in the body of the response.

        return response.data; //pass the data array into Tabulator
    },
});