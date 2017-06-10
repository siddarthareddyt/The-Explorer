using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace TheExplorer
{
    [DataContract]
    public class CaptchaResponse
    {
        [DataMember(Name = "success")]
        public string success { get; set; }

        [DataMember(Name = "challenge_ts")]
        public string challenge_ts { get; set; }
    }
}