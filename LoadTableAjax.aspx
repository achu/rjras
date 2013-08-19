<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoadTableAjax.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery-1.10.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
            });
            var jsonData;
            $("body").on("click", "#btnLoadTable", function () {
                $.ajax({
                    type: "POST"
                    , url: "LoadTableAjax.aspx/LoadTable"
                    , data: {}
                    , contentType: "application/json; charset=utf-8"
                    , dataType: "json"
                    , success: function (msg) {
                        jsonData = $.parseJSON(msg.d);
                        GenerateTable(jsonData);
                    }
                    , failure: function (msg) {
                        alert(msg.d);
                    }
                });
            });

            function GenerateTable(jsonData) {
                FillJSONData(jsonData);
                ConstructTable(jsonData);
                DoSorting();
            }

            function FillJSONData(jsonData) {
                for (var i = 0; i < jsonData.length; i++) {
                    //jsonData[i].sortOrder = "";
                }
            }


            function ConstructTable(jsonData) {
                if (jsonData.length > 0) {
                    var tblChange = $("#tblChange");
                    tblChange.empty();
                    for (var key in jsonData[0]) {
                        if ($("#tblChange").find("thead").length == 0) {
                            var tHead = $("#tblChange").find("thead");
                            tblChange.append("<thead>").children("thead")
                                .append("<tr>").children("tr")
                                .append("<th><label>" + key + "</label></th>");
                        }
                        else {
                            tblChange.find("thead").find("tr").append("<th>" + key + "</th>");
                        }
                    }
                    for (var i = 0; i < jsonData.length; i++) {
                        tblChange.append("<tbody>").children("tbody");
                        var tRow = tblChange.find("tbody").append("<tr>").children("tr:last");
                        $.each(jsonData[i], function (index, obj) {
                            tRow.append("<td>" + obj + "</td>");
                        });
                    }
                }
            }

            function DoSorting() {
                $("#tblChange th").each(function () {
                });

            }

            $("body").on("click", "#tblChange th", function (event) {

                //"▲"
                var thisElement = $(this);
                //alert(thisElement.data("sortOrder"));
                var property = $(event.target).text();
                var sortAsc = ($(this).data("sortOrder") == undefined || $(this).data("sortOrder") == '' || $(this).data("sortOrder") == false) ? true : false;
               
                
                //alert($(this).data("sortOrder"));
                jsonData = $(jsonData).sort(function (a, b) {
                    if (sortAsc) return (a[property] > b[property]) ? 1 : ((a[property] < b[property]) ? -1 : 0);
                    else return (b[property] > a[property]) ? 1 : ((b[property] < a[property]) ? -1 : 0);
                });
                GenerateTable(jsonData);
                thisElement.data("sortOrder", sortAsc);
            });
        </script>
        <div>
            <label id="lblSample">Some text inside this label</label>
            <input type="button" id="btnLoadTable" value="load table" />
        </div>
        <div>
            <table id="tblChange"></table>
        </div>
    </form>
</body>
</html>
