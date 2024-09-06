--Physics.FramesPerTick = 2

if not sb_EXPLOSIONS_destruct then sb_EXPLOSIONS_destruct = {} end
--projectile impact effects { projectile_savename, effect_path, destroy_type**, use_included_path*}
if not sb_EXPLOSIONS_impact then sb_EXPLOSIONS_impact = {} end

table.insert(sb_EXPLOSIONS_impact, {"sbpp_hellcat", "plane_overlay.lua", {0,0,1,1,1,1,1,0,0,0,0}, 1})
table.insert(sb_EXPLOSIONS_impact, {"sbpp_p51", "plane_overlay.lua", {0,0,1,1,1,1,1,0,0,0,0}, 1})
table.insert(sb_EXPLOSIONS_impact, {"sbpp_f16", "plane_overlay.lua", {0,0,1,1,1,1,1,0,0,0,0}, 1})
table.insert(sb_EXPLOSIONS_impact, {"sbpp_apache", "plane_overlay.lua", {0,0,1,1,1,1,1,0,0,0,0}, 1})
table.insert(sb_EXPLOSIONS_impact, {"sbpp_littlebird", "plane_overlay.lua", {0,0,1,1,1,1,1,0,0,0,0}, 1})