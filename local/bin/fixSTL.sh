suffix=".stl"
fn=${1%$suffix}
slic3r --repair $fn".stl"
slic3r --cut 0.0001 $fn"_fixed.obj"
rm $fn"_fixed.obj"
rm $fn"_fixed.obj_lower.stl"
mv $fn"_fixed.obj_upper.stl" $fn"_fixed.stl"
