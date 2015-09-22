note
	description: "Implement the class Abstract_Subject of the design observer pattern."
	author: ""
	date: "31/08/2012"
	revision: "See SVN rev. number"

class
	ABSTRACT_SUBJECT

create
	make_subject

feature{ANY}  -- Initialization

	make_subject
		do
			create observers_list.make
		ensure
			initialize_list: observers_list.is_empty()
		end

feature -- Status Report

	is_observed_by(x : ABSTRACT_OBSERVER): BOOLEAN
			--Return true if x is an observer of the subject
		do
			Result := observers_list.has (x)
		ensure
			does_it_belongs: Result = observers_list.has (x)
		end

feature -- Status Settings

	subscribe(x :ABSTRACT_OBSERVER)
			--Add the X observer to a current subject.
		do
        	if (not is_observed_by (x))
            then
            	observers_list.put_front (x)
            end
		ensure
			belongs_in_list: is_observed_by(x)
		end

	unsubscribe(x :ABSTRACT_OBSERVER)
			--Delete the X observer from the current subject.
		do
			observers_list.prune (x)
		ensure
			is_not_observed_by_x: not is_observed_by (x)
		end


	update
		        --Indicates that all observers of the current subject should be updated
		local
			i : INTEGER
			j : INTEGER
		do
			j := observers_list.count
			from
				i := 1
			until
				i > j
			loop
				observers_list[i].on_update
				i := i + 1
			end
		end

feature{NONE} -- Implementation

	observers_list : LINKED_LIST [ABSTRACT_OBSERVER]

end





