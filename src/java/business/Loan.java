
package business;

public class Loan {
    private double principal, rate, mopmt;
    private int term;
    private double[] bbal, ichrg, ebal;
    private boolean built;
    public Loan() {
        this.principal = 0;
        this.rate = 0;
        this.term = 0;
        built = false;
    }
    public Loan(double p,double r,int t) {
		this.principal = p;
		this.rate = r;
		this.term = t;
		this.mopmt = calcMoPmt();
		buildLoan();
	}
    public void setPrincipal(double p) {
        this.principal = p;
        built = false;
    }
    public double getPrincipal() {
        return this.principal;
    }
    public void setRate(double r) {
        this.rate = r;
        built = false;
    }
    public double getRate() {
        return this.rate;
    }
    public void setTerm(int t) {
        this.term = t;
        built = false;
    }
    public int getTerm() {
        return this.term;
    }
	public double getMonthlyPayment() {
		if (!built) {
			this.mopmt = calcMoPmt();
			buildLoan();
		}
		return this.mopmt;
	}
    public double getBegBal(int m) {
        if (!built) {
            buildLoan();
        }
        return this.bbal[m-1];
    }
    public double getIntCharged(int m) {
        if (!built) {
            buildLoan();
        }
        return this.ichrg[m-1];
    }
    public double getEndBal(int m) {
        if (!built) {
            buildLoan();
        }
        return this.ebal[m-1];
    }
	private double calcMoPmt() {
	        double mp, mrate, denom;
	        mrate = this.rate / 12.0;
	        denom = Math.pow(1 + mrate, term)-1;
	        mp = (mrate + (mrate/denom))*principal;
	        return mp;
    }
    private void buildLoan() {
        bbal = new double[term];
        ichrg = new double[term];
        ebal = new double[term];

        bbal[0] = this.principal;


        for (int i=0;i < this.term; i++) {
            if (i > 0) {
                bbal[i] = ebal[i-1];
            }
            ichrg[i] = bbal[i]*(this.rate/12.0);
            ebal[i] = bbal[i] + ichrg[i] - this.mopmt;
        }
        built = true;
        return ;
    }
}