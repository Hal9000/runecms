RuneCMS is intended to be a simple, lightweight tool for building
and deploying static websites.
<br><br>
It's based on Livetext, but could be generalized to be agnostic of
that tool. It is abstracted from a portion of RuneBlog.
<br><br>
In its present form, the <t>rcms</t> command simply takes a parameter.
Choices are:
<br><br>
<br><center><table width=90% cellpadding=5>
<tr>
  <td valign=top><t>rcms version</t></td>
  <td valign=top>Print the version number of RuneCMS</td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms config</t></td>
  <td valign=top>Initialize <t>config.txt</t> if necessary and edit with <t>vi</t></td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms check</t></td>
  <td valign=top> List stale files, but do nothing else</td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms generate</t></td>
  <td valign=top>Find stale files under <t>source/</t> and generate them under <t>target/</t></td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms publish</t></td>
  <td valign=top>Publish <t>target/</t> to the remote server</td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms update</t> </td>
  <td valign=top>Shortcut - Like a generate followed by a publish</td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms view</t></td>
  <td valign=top>View the current state of <t>target/</t> via browser (local files)</td>
</tr>
<tr>
</tr>
<tr>
  <td valign=top><t>rcms browse</t></td>
  <td valign=top>Browse the current state of the remote server</td>
</tr>
</table></center>
At present, there is no check for these to be done in order. For example, 
you could publish without a generate (analogous to editing a C program
and running the executable without recompiling it).
<br><br>
The assumption is made that keys for the user and server are already 
set up. The <t>config.txt</t> file looks like:
<pre>
server: foo.com
path: /var/www/foo
user: hal9000
</pre>
<hr>
<b>Original notes:</b>
<pre>
General idea: Website is stored in a directory tree. Use Livetext (etc.?) to create target files
and rsync to upload.
<br><br>
Config will comprise:
  - server
  - user
  - root/path
<br><br>
Dir structure:
<br><br>
  site
   |
   +---- config.lt3
   +---- source/...
   +---- target/...
<br><br>
Logic flow:
  1. Edit file(s) under source/ tree
  2. Generate 
      - reads config
      - finds modified files under source/
      - runs livetext on each
      - results go under target/
  3. View target/ locally to verify
  4. Publish via rsync
      # cmd = "rsync -r -z #{target}/ #@user@#@server:#{path}/"
</pre>
<br><br>
More details later...
