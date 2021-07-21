using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_MemberList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }

        if (Mode == "delete")
        {
            DeleteMember();
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            Bind(0);
        }
    }

    private void DeleteMember()
    {
        try
        {
            MemberManager mm = new MemberManager();
            MemberManager.Delete(ID);
            Response.Redirect("memberlist.aspx");
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to delete member.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    private void Bind(int pageIndex)
    {
        try
        {
            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                string query = "SELECT ID, Email, Createdate, Newsletter, UserType, MemberName, Status, Password " +
                " FROM Member AS M WHERE UserType <> 1 ";

                if (MemberTypeDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(UserType = {1})", query, MemberTypeDropDown.SelectedValue);
                }

                if (StatusDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(Status = {1})", query, StatusDropDown.SelectedValue);
                }

                if (SubscribeList.SelectedValue != "")
                {
                    query = string.Format("{0} AND(Newsletter = {1})", query, SubscribeList.SelectedValue);
                }

                query = string.Format("{0} ORDER BY CreateDate desc ", query);

                MemberGridView.DataSource = db.ExecuteQuery<Member>(query, new object[] { }).ToList<Member>();
                MemberGridView.PageIndex = pageIndex;
                MemberGridView.DataBind();
            }
        }
        catch(Exception ex)
        {
            Trace.Write("Unable to fetch member records.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void btnDeleteRecords_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in MemberGridView.Rows)
        {
            if ((row.FindControl("chkSelect") as CheckBox).Checked)
            {
                int Emp_ID = Convert.ToInt32(MemberGridView.DataKeys[row.RowIndex].Value);
                using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    db.ExecuteCommand("DELETE FROM Member WHERE ID = " + Emp_ID, new object[] { });
                }
            }
        }

        Bind(0);
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Bind(0);
    }

    protected void MemberGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Bind(e.NewPageIndex);
    }
    protected void MemberGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1)
        {
            switch (e.Row.Cells[5].Text)
            {
                case "2":
                    e.Row.Cells[5].Text = "Author";
                    break;
                case "3":
                    e.Row.Cells[5].Text = "Member";
                    break;
            }

            switch (e.Row.Cells[7].Text)
            {
                case "0":
                    e.Row.Cells[7].Text = "Active";
                    break;
                case "2":
                    e.Row.Cells[7].Text = "Deleted";
                    break;
                case "1":
                    e.Row.Cells[7].Text = "Inactive";
                    break;
                case "3":
                    e.Row.Cells[7].Text = "Unverified";
                    break;
            }
        }
    }
}