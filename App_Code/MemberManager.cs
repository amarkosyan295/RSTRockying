using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class MemberManager
    {
        public static bool ValidateUser(string username, string password)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    int count = (from t in dc.Members where t.Email == username && t.Password == password && t.Status == (byte)GeneralStatusType.Active select t).Count();
                    if (count == 1)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public static MemberTypeType UserType(string username)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    Member m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    if (m != null)
                    {
                        return (MemberTypeType)(Enum.Parse(typeof(MemberTypeType), m.UserType.ToString()));
                    }
                    else
                    {
                        return MemberTypeType.Reader;
                    }
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write(ex.Message);
                HttpContext.Current.Trace.Write(ex.StackTrace);
                return MemberTypeType.Reader;
            }
        }

        public static bool Update(string username,
            string name, bool newsletter,
            DateTime dob, string country, string alternateEmail,
            string mobile, string alternateEmail2,
            string phone, string address,
            string lastname, long modifiedby,
            string gender, MemberTypeType mtype)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.MemberName = name;
                    m.Newsletter = newsletter;
                    m.DOB = dob;
                    m.Country = country;
                    m.AlternateEmail = alternateEmail;
                    m.AlternateEmail2 = alternateEmail2;
                    m.Mobile = mobile;
                    m.Phone = phone;
                    m.Address = address;
                    m.LastName = lastname;
                    m.ModifiedBy = modifiedby;
                    m.ModifyDate = DateTime.Now;
                    m.Gender = char.Parse(gender);
                    m.UserType = (byte)mtype;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool Update(string username, string name, bool newsletter, GeneralStatusType status)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.MemberName = name;
                    m.Newsletter = newsletter;
                    m.Status = (byte)status;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member UpdateLastLogon(string username)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.LastLogon = DateTime.Now;
                    dc.SubmitChanges();
                    return m;
                }
            }
            catch
            {
                throw;
            }
        }

        public static void Delete(int id)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.ID == id select t).SingleOrDefault();
                    m.Status = (byte)GeneralStatusType.Deleted;
                    dc.SubmitChanges();

                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("Unable to delete account");
                HttpContext.Current.Trace.Write(ex.Message);
                HttpContext.Current.Trace.Write(ex.StackTrace);
            }
        }

        public static bool Delete(string id, long modifiedBy)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.Email == id select t).SingleOrDefault();
                    m.Status = (byte)GeneralStatusType.Deleted;
                    m.ModifiedBy = modifiedBy;
                    m.ModifyDate = DateTime.Now;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static Guid AssignDriveId(long id)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var m = (from t in dc.Members where t.ID == id select t).SingleOrDefault();
                    if (!m.DriveID.HasValue)
                    {
                        m.DriveID = Guid.NewGuid();
                    }
                    dc.SubmitChanges();
                    return m.DriveID.Value;
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member GetUser(string username)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    return (from t in dc.Members where (t.Email == username || t.UserName == username) && t.Status != (byte)GeneralStatusType.Deleted select t).SingleOrDefault();
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member GetUser(int id)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    return (from t in dc.Members where t.ID == id select t).SingleOrDefault();
                }
            }
            catch
            {
                throw;
            }
        }

        public static List<Member> GetMemberList()
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    return (from u in dc.Members where u.Status != (byte)GeneralStatusType.Deleted orderby u.Createdate descending select u).ToList<Member>();
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool ActivateUser(string id)
        {

            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Member m = (from u in dc.Members where u.Email == id select u).SingleOrDefault();
                if (m != null)
                {
                    m.Status = (byte)GeneralStatusType.Active;
                    dc.SubmitChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }

        }

        public static bool ToggleSubscriptionUser(long id, bool value)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    Member m = (from u in dc.Members where u.ID == id select u).SingleOrDefault();
                    m.Newsletter = value;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool ChangePassword(long id, string password)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Member m = (from u in dc.Members where u.ID == id select u).SingleOrDefault();
                m.Password = password;
                dc.SubmitChanges();
                return true;
            }
        }

        public static bool CreateUser(string username, string password, bool newsletter, string memberName, DateTime? dob,
            string gender, MemberTypeType mtype)
        {
            try
            {
                if (username.Trim() == string.Empty)
                {
                    return false;
                }
                if (password.Trim() == string.Empty)
                {
                    return false;
                }
                if (EmailExist(username))
                {
                    return false;
                }

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    Member m = new Member();
                    m.Createdate = DateTime.Now;
                    m.Email = username;
                    m.MemberName = memberName;
                    m.Newsletter = newsletter;
                    m.Password = password;
                    m.Status = (byte)GeneralStatusType.Unverified;
                    m.UserType = (byte)mtype;
                    m.DOB = dob;
                    m.Gender = char.Parse(gender);
                    dc.Members.InsertOnSubmit(m);
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool EmailExist(string email)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    int count = (from t in dc.Members where t.Email == email select t).Count();
                    if (count > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool UserNameExist(string username)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    int count = (from t in dc.Members where t.UserName == username select t).Count();
                    if (count > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
    }
}