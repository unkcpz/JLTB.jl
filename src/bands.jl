module bands

using ..hamiltonian

function eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists, nk, dim)
    no = size(orbitals, 1)

    k = zeros(Float64, dim)
    eigenvals = zeros(Float64, nk, no)
    for r in 1:size(kvectors, 1)
        k .= kvectors[r, :]
        eigenvals[r, :] .= eigens(k, onsites, hoppings, orbitals)
    end
    return kdists, eigenvals'
end

function eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists)
    nk = length(kdists)
    dim = size(kvectors, 2)

    eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists, nk, dim)
end
