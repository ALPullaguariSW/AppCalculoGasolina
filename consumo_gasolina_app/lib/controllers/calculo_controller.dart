import '../models/consumo_model.dart';

class CalculoController {
  static ConsumoModel calcularConsumo({
    required double km,
    required double precioPorLitro,
    required double dineroGastado,
    required int horas,
    required int minutos,
  }) {
    final minutosTotales = (horas * 60) + minutos;
    final litrosConsumidos = dineroGastado / precioPorLitro;
    final litrosPorKm = litrosConsumidos / km;
    final costoPorKm = litrosPorKm * precioPorLitro;
    final litrosPor100Km = litrosPorKm * 100;
    final costoPor100Km = costoPorKm * 100;
    final velocidadMediaKmh = km / (minutosTotales / 60);
    final velocidadMediaMs = velocidadMediaKmh * (1000 / 3600);

    return ConsumoModel(
      litrosConsumidos: litrosConsumidos,
      litrosPorKm: litrosPorKm,
      costoPorKm: costoPorKm,
      litrosPor100Km: litrosPor100Km,
      costoPor100Km: costoPor100Km,
      velocidadMediaKmh: velocidadMediaKmh,
      velocidadMediaMs: velocidadMediaMs,
    );
  }
}
