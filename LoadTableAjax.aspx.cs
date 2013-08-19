using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetData();
        }
    }

    [WebMethod]
    public static string LoadTable()
    {
        return GetData();
    }

    private static string GetData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("empid");
        dt.Columns.Add("empfname");
        dt.Columns.Add("emplname");
        dt.Columns.Add("empdob");
        dt.Columns.Add("empgen");

        DataRow dr = dt.NewRow();
        dr["empid"] = "00001";
        dr["empfname"] = "achutha krishnan";
        dr["emplname"] = "bathey";
        dr["empdob"] = "06/26/1985";
        dr["empgen"] = "M";
        dt.Rows.Add(dr);

        DataRow dr1 = dt.NewRow();
        dr1["empid"] = "00002";
        dr1["empfname"] = "ohm ganesh";
        dr1["emplname"] = "srinivasan";
        dr1["empdob"] = "03/22/1982";
        dr1["empgen"] = "M";
        dt.Rows.Add(dr1);

        DataRow dr2 = dt.NewRow();
        dr2["empid"] = "00003";
        dr2["empfname"] = "kathiravan";
        dr2["emplname"] = "palinivelu";
        dr2["empdob"] = "03/14/1981";
        dr2["empgen"] = "M";
        dt.Rows.Add(dr2);

        DataRow dr3 = dt.NewRow();
        dr3["empid"] = "00004";
        dr3["empfname"] = "minu";
        dr3["emplname"] = "raj";
        dr3["empdob"] = "04/26/1985";
        dr3["empgen"] = "F";
        dt.Rows.Add(dr3);

        return DataTableToJSON(dt);

    }

    private static string DataTableToJSON(DataTable table)
    {
        string delimiter = string.Empty;
        string comma = string.Empty;
        StringBuilder json = new StringBuilder("[");
        foreach (DataRow row in table.Rows)
        {
            json.Append(delimiter);
            json.Append("{");
            foreach (DataColumn col in table.Columns)
            {
                json.Append(comma);
                json.Append("\"" + col.ColumnName + "\":\"" + row[col.ColumnName].ToString() + "\"");
                comma = ",";
            }
            json.Append("}");
            comma = string.Empty;
            delimiter = ",";
        }
        json.Append("]");
        return json.ToString();
    }


   
}