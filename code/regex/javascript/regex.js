var r1 = "";
var r2 = "";
var i = 0;

while(i < 29) {
	i += 1;
	r1 += "a?";
	r2 += "a";

	var r = new RegExp(r1 + r2);
	if(r.test(r2)) {
		console.log(r2 + " matches " + r);
	} else {
		console.log("matching failure");
	}
}