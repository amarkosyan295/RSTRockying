using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying.Models;
using Rockying;

public partial class control_message : System.Web.UI.UserControl
{
    public AlertType Indicate { get; set; }

    public string Heading
    {
        get
        {
            return HeadingLit.Text;
        }
        set
        {
            HeadingLit.Text = value;
        }

    }

    public string Text
    {
        get
        {
            return TextLit.Text;
        }
        set
        {
            TextLit.Text = value;

        }
    }

    public string Block {
        get
        {
            if (Indicate == AlertType.Error)
            {
                return "alert-error";
            }
            else if (Indicate == AlertType.Success)
            {
                return "alert-success";
            }
            else if (Indicate == AlertType.Warning)
            {
                return "alert-block";
            }
            else if (Indicate == AlertType.Info)
            {
                return "alert-info";
            }
            else
            {
                return "";
            }
        }
    }

    public bool HideClose { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}