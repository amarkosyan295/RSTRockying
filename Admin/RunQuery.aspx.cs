using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_RunQuery : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        try
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                int rows = dc.ExecuteCommand(QueryTextBox.Text.Trim());
                message1.Text = string.Format("Command executed successfully. {0} rows affected.", rows);
                message1.Indicate = AlertType.Success;
                message1.Visible = true;
            }
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("{0}<br/>{1}<br/>{2}", ex.Message, ex.Source, ex.StackTrace);
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
        }
    }
}