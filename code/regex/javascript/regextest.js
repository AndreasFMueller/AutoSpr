//
// regextest.js -- Performance Messung der Javascript regex engine
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//

//
// Klasse zur Performance Messung
//
class RegexTest {
	constructor(n) {
		this.n = n;
		let r1 = "";
		let r2 = "";
		let i = 0;

		while(i < n) {
			i += 1;
			r1 += "a?";
			r2 += "a";
		}
		this.re = (r1 + r2);
		this.s = r2;
		this.engine = new RegExp(r1 + r2);
	}
	matchTime() {
		let startTime = performance.now();
		if (this.engine.test(this.s)) {
			console.log("length " + this.n + " matches");
		} else {
			console.log("length " + this.n + " matching failure");
		}
		let endTime = performance.now();
		let runtime = endTime - startTime;
		console.log("match time: %f", runtime);
		return endTime - startTime;
	}
}

var router = new VueRouter({
	mode: 'history',
	routes: []
});

var app = new Vue(
{
	router,
	el: "#regex",
	data: {
		minn:	1,
		maxn:	500000,
		resultate: [
		]
	},
	methods: {
		getData() {
			let n = this.minn;
			let i = 0;
			while (n < this.maxn) {
				console.log("working on " + n);
				let	x = new RegexTest(n);
				let	t = x.matchTime();
				this.resultate[i] = {
					laenge: n,
					zeit: t
				};
				console.log("match time: " + this.resultate[i].zeit);
				n = 2 * n;
				i = i + 1;
			}
		}
	},
	beforeMount() {
		this.getData();
	}
})

