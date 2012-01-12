require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Array#join" do
  it "is not affected if the array is empty" do
    r = [].join
    r.should == ""
    r.should_not be_html_safe

    r = [].join("x".html_safe)
    r.should == ""
    r.should_not be_html_safe
  end

  it "is not affected if the first element is not an html safe buffer" do
    r = [1, 2, 3].join
    r.should == "123"
    r.should_not be_html_safe

    r = ["", "<>".html_safe].join("x".html_safe)
    r.should == "x<>"
    r.should_not be_html_safe
  end

  it "returns an html_safe string if the first element is an html safe buffer" do
    r = ["<br/>".html_safe, 2, "<p/>"].join(" & ")
    r.should == "<br/> &amp; 2 &amp; &lt;p/&gt;"
    r.should be_html_safe
  end

  it "returns a string if the first element is a non html safe buffer" do
    first = "<br/>".html_safe.upcase!
    first.should_not be_html_safe # sanity check
    first.class.should_not == String # sanity check
    r = [first, 2, "<p/>"].join(" & ")
    r.should == "<BR/> & 2 & <p/>"
    r.should_not be_html_safe
  end

end
