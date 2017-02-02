function sequence = cleanPasses(person)
%cleanPasses converts a given person column vector of first column closest person to a pass sequence

numberOfPoints = length(person);
person2 = person;

for i = 1:numberOfPoints
    if i >= 10
    person2(i) = mode(person((i-9):i));
    end
end

person = person2;
for i = 1:numberOfPoints
    if i >= 10
    person(i) = mode(person2((i-9):i));
    end
end

person = person(10:numberOfPoints);

i = 2;
while i < length(person)
    if person(i) == person(i-1) || person(i) == 0
        person(i) = [];
    else
        i = i+1;
    end
end

if length(person)>1
    person(length(person)) = [];
end

sequence = person;

end

