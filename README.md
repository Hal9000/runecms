RuneCMS is intended to be a simple, lightweight tool for building
and deploying static websites.
<p>

It's based on Livetext, but could be generalized to be agnostic of
that tool. It is abstracted from a portion of RuneBlog.
<p>

In its present form, the <font size=+1><tt>rcms</tt></font> command simply takes a parameter.
Your choices are:
<br><center><table width=90% cellpadding=5>
<tr>
  <td valign=top><font size=+1><tt>rcms config</tt></font>  </td>
  <td valign=top>Initialize <font size=+1><tt>config.txt</tt></font> if necessary and edit with <font size=+1><tt>vi</tt></font></td>
</tr>
<tr>
  <td valign=top><font size=+1><tt>rcms generate</tt></font></td>
  <td valign=top>Find stale files under <font size=+1><tt>source/</tt></font> and generate them under <font size=+1><tt>target/</tt></font></td>
</tr>
<tr>
  <td valign=top><font size=+1><tt>rcms view</tt></font>    </td>
  <td valign=top>View the current state of <font size=+1><tt>target/</tt></font> via browser (local files)</td>
</tr>
<tr>
  <td valign=top><font size=+1><tt>rcms publish</tt></font> </td>
  <td valign=top>Publish <font size=+1><tt>target/</tt></font> to the remote server</td>
</tr>
<tr>
  <td valign=top><font size=+1><tt>rcms browse</tt></font>  </td>
  <td valign=top>Browse the current state of the remote server</td>
</tr>
</table></center>
At present, there is no check for these to be done in order. For example, 
you could publish without a generate (analogous to editing a C program
and running the executable without recompiling it).
<p>

The assumption is made that keys for the user and server are already 
set up. The <font size=+1><tt>config.txt</tt></font> file looks like:
<p>

<pre>
server: foo.com
path: /var/www/foo
user: hal9000
</pre>
<p>

<p>

More details later...
<p>

