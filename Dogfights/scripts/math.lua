function Vec2Rad(vector)
	--convert vector to radians
	return math.atan2(vector.y , vector.x)
end
function Rad2Vec(radians)
	--convert radians to vector
	return Vec3(math.cos(radians), math.sin(radians))
end
function AddVec(vector1, vector2)
	--add vectors
	local vector3 = Vec3(0,0)
	vector3.x = vector1.x + vector2.x
	vector3.y = vector1.y + vector2.y
	vector3.z = vector1.z + vector2.z
	return vector3
end
function SubtractVec(vector1, vector2)
	--subtract vectors
	local vector3 = Vec3(0,0)
	vector3.x = vector1.x - vector2.x
	vector3.y = vector1.y - vector2.y
	vector3.z = vector1.z - vector2.z
	return vector3
end
function MultiplyVec(vector1, magnitude)
	--multiply vectors
	local vector3 = Vec3(0,0)
	vector3.x = vector1.x * magnitude
	vector3.y = vector1.y * magnitude
	vector3.z = vector1.z * magnitude
	return vector3
end
function DivideVec(vector1, magnitude)
	--divide vectors
	local vector3 = Vec3(0,0)
	vector3.x = vector1.x / magnitude
	vector3.y = vector1.y / magnitude
	vector3.z = vector1.z / magnitude
	return vector3
end
function RoundFloat(number)
	--round float to whole number
	return math.floor(number + 0.5)
end
function RadVec2Vec(vectorfrom, vectorto)
	--get the radian angle from one vector to another
	local vector = SubtractVec(vectorto, vectorfrom)
	return Vec2Rad(vector)
end
function Vec2Mag(vector)
	--get magnitude from vector
	return math.sqrt(vector.x^2 + vector.y^2)
end
function Trig_C_abB(a, b, B)
	--find angle C, given sides a b and angle B
	local A = math.asin((a * math.sin(B)) / b)
	local C = math.pi - B - A
	return C
end